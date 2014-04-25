# -*- coding: utf-8 -*-
#
# Copyright 2014 Roy Liu
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.

require "pathname"
require "sprockets/rails/helper"
require "asset_pages/monkey_patches"

module AssetPages
  module Jekyll
    module LiquidHelper
      Root = Pathname.new("/")

      def self.included(klass)
        klass.class_eval do
          include Sprockets::Rails::Helper
          include InstanceMethods

          def self.configure_assets
            klass = self

            ::Rails.application.configure do |app|
              manifest_dir = config.assets.manifest \
                || Pathname.new(config.paths["public"].first) \
                  .join(Pathname.new(config.assets.prefix).relative_path_from(Root))

              klass.debug_assets = config.assets.debug
              klass.digest_assets = config.assets.digest
              klass.assets_prefix = config.assets.prefix

              if config.assets.compile
                klass.assets_environment = app.assets
                klass.assets_manifest = Sprockets::Manifest.new(app.assets, manifest_dir)
              else
                klass.assets_manifest = Sprockets::Manifest.new(manifest_dir)
              end
            end
          end
        end

        klass.configure_assets
      end

      module InstanceMethods
        def compute_asset_path(path, options = {})
          asset = lookup_asset_for_path(path, options)

          if !asset.nil?
            if debug_assets && options[:debug] != false
              asset.to_a.each do |subasset|
                write_static_asset({}.tap { |h| subasset.encode_with(h) }.tap { |h| h["source"] ||= subasset.source })
              end
            else
              write_static_asset({}.tap { |h| asset.encode_with(h) }.tap { |h| h["source"] ||= asset.source })
            end
          elsif assets_environment.nil?
            asset_filename = assets_manifest.assets[path]

            write_static_asset({"filename" => asset_filename}) \
              if !asset_filename.nil?
          end

          # Use relative paths, since the filesystem might be used to serve up pages.
          super(path, options)
        end

        protected

        def site
          @context.registers[:site]
        end

        def page_dir
          Pathname.new(@context.registers[:page]["dir"])
        end

        def relativize(path)
          Pathname.new(path).relative_path_from(page_dir).to_s
        end

        def relativized?(path)
          path.start_with?("../") || "/#{path}".start_with?("#{assets_prefix}/")
        end

        private

        def write_static_asset(asset_hash)
          assets_dir = Pathname.new(assets_prefix).relative_path_from(Root)

          if asset_hash["filename"].nil?
            staging_dir = ::Rails.application.root.join("tmp/cache", "_#{::Rails.env}")
            site_file_relative = assets_dir.join(asset_hash["logical_path"])
            site_file = staging_dir.join(site_file_relative)

            parent_dir = site_file.parent

            parent_dir.mkpath \
              if !parent_dir.directory?

            # Write the asset into the staging directory.
            site_file.open("wb") { |f| f.write(asset_hash["source"]) } \
              if !site_file.file? || site_file.mtime < Time.at(asset_hash["mtime"])
          else
            staging_dir = Root.relative_path_from(Pathname.new(assets_prefix)).expand_path(assets_manifest.dir)
            site_file_relative = assets_dir.join(asset_hash["filename"])
          end

          # Add to Jekyll's static file manifest, which ensures that said asset is moved into place.
          site.static_files \
            .push(::Jekyll::StaticFile.new(self,
                                           staging_dir,
                                           site_file_relative.dirname,
                                           site_file_relative.basename)) \
            .uniq!
        end
      end
    end
  end
end
