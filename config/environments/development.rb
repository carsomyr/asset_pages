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

  # Disable caching of classes and reload them with each request.
  config.cache_classes = false

  # Enable full error reports and disable caching.
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false

  # Log deprecation notices.
  config.active_support.deprecation = :log

  # Enable asset pipeline debugging messages.
  config.assets.debug = true

  # Disable eager loading.
  config.eager_load = false

  # Don't actually send emails in development mode.
  config.action_mailer.perform_deliveries = false
end
