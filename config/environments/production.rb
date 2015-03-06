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

Rails.application.configure do
  # Settings specified here will take precedence over those in `config/application.rb`.

  # Use less verbose logging.
  config.log_level = :info

  # Enable caching of classes and don't reload them with each request.
  config.cache_classes = true

  # Disable full error reports and enable caching.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable Rails' static file server and defer to something like Apache or Nginx.
  config.serve_static_files = false

  # Enable asset pipeline compression.
  config.assets.css_compressor = :sass
  config.assets.js_compressor = :uglifier

  # Disable on-the-fly asset pipeline compilation for missing assets.
  config.assets.compile = false

  # Enable digest generation for asset URLs.
  config.assets.digest = true

  # Enable eager loading.
  config.eager_load = true
end
