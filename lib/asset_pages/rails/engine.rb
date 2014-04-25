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

require "sprockets/rails"

module AssetPages
  module Rails
    class Engine < ::Rails::Engine
      config.after_initialize do |app|
        app.assets.context_class.class_eval do
          include InstanceMethods
        end
      end

      module InstanceMethods
        def compute_asset_path(path, options = {})
          path = super

          if path.start_with?("#{assets_prefix}/")
            Pathname.new(path).relative_path_from(Pathname.new(assets_prefix)).to_s
          else
            path
          end
        end
      end
    end
  end
end
