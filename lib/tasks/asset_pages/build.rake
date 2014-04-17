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

require "jekyll"

desc "An alias for asset_pages:build"
task asset_pages: "asset_pages:build"

namespace :asset_pages do
  desc "Run `jekyll build` for development"
  task build: "prepare_assets" do
    configs = []

    default_config = Rails.application.root.join("_config.yml")

    configs.push(default_config) \
      if default_config.file?

    configs += Rails.application.root.join("config/jekyll").children.select do |pathname|
      pathname.file? && pathname.extname == ".yml"
    end

    # Load plugins at the last possible moment.
    require "asset_pages/jekyll/plugins"

    Jekyll::Commands::Build.process(
        config: configs,
        source: Rails.application.root.join("public"),
        destination: Rails.application.root.join("_#{Rails.env}"),
        exclude: ["assets"]
    )
  end

  desc "Precompile assets and run `jekyll build` for production"
  task precompile: "build"
end
