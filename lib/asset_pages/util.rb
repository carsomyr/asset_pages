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
require "jekyll/configuration"

module AssetPages
  module Util
    def self.find_yaml_configs
      root = ::Rails.application.root
      configs = []

      default_config = root + "_config.yml"

      configs.push(default_config) \
        if default_config.file?

      configs += (root + "config/jekyll").children.select do |pathname|
        pathname.file? && pathname.extname == ".yml"
      end

      configs
    end

    def self.jekyll_config
      ::Jekyll.configuration(config: find_yaml_configs)
    end
  end
end
