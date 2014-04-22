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
require "yaml"

begin
  require "requirejs/rails"
rescue LoadError
end

require "asset_pages/jekyll/plugins/asset_tag"

module Jekyll
  class RequireJsIncludeTag < AssetTag
    include RequirejsHelper

    class << self
      attr_accessor :precompiled_modules
    end

    klass = self

    Rails.application.configure do
      rjs_manifest_file = config.requirejs.manifest_path

      if !config.assets.compile
        klass.assets_manifest.assets.merge!(YAML.load(rjs_manifest_file.open { |f| f.read })) \
          if rjs_manifest_file.file?

        klass.precompiled_modules = Set.new(config.requirejs.build_config["modules"].map do |mod|
          config.requirejs.module_name_for(mod)
        end)
      else
        klass.precompiled_modules = Set.new
      end
    end

    def javascript_path(path, options = {})
      if RequireJsIncludeTag.precompiled_modules.include?(path)
        Pathname.new(super).relative_path_from(Pathname.new(assets_prefix).relative_path_from(page_dir)).to_s
      else
        super
      end
    end

    def baseUrl(path)
      Pathname.new(assets_prefix).relative_path_from(page_dir).to_s
    end

    def render(context)
      super

      raise ArgumentError, "Please provide exactly one argument to `requirejs_include_tag`" \
        if sources.size != 1

      source = sources[0]
      requirejs_include_tag(source)
    end

    Liquid::Template.register_tag("requirejs_include_tag", self)
  end \
    if defined?(Requirejs::Rails)
end
