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

  # Enable caching of classes and don't reload them with each request.
  config.cache_classes = true

  # Enable full error reports and disable caching.
  config.consider_all_requests_local = true

  # Print deprecation notices to stderr.
  config.active_support.deprecation = :stderr

  # Enable Rails' static asset server and tune it.
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  # Disable rendering of exception templates, and instead raise exceptions.
  config.action_dispatch.show_exceptions = false

  # Disable eager loading.
  config.eager_load = false
end
