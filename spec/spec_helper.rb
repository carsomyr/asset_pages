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
ENV["RAILS_ENV"] ||= "test"
require Pathname.new("../../config/environment").expand_path(__FILE__)
require "rspec/rails"
require "rspec/autorun"

Pathname.glob("spec/support/**/*.rb").each { |f| require f }

# Checks for pending migrations before tests are run.
ActiveRecord::Migration.check_pending! \
  if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures.
  config.fixture_path = Rails.application.root + "spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your examples within a transaction, remove the
  # following line or assign `false` instead of `true`.
  config.use_transactional_fixtures = true

  # If `true`, the base class of anonymous controllers will be inferred automatically. This will be the default behavior
  # in future versions of rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an order dependency and want to debug it, you
  # can fix the order by providing the seed, which is printed after each run.
  #
  #     --seed 1234
  config.order = "random"

  # Use color.
  config.color_enabled = true

  # Use the given formatter.
  config.formatter = :documentation
end
