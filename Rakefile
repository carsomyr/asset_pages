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

Rake.application.top_level_tasks.each do |task_name|
  if ENV["RAILS_ENV"].nil?
    case task_name
      when "asset_pages", "asset_pages:build"
        ENV["RAILS_ENV"] = "development"
      when "asset_pages:precompile", "gh_pages:push"
        ENV["RAILS_ENV"] = "production"
    end
  else
    break
  end
end

require Pathname.pwd.join("config/environment")

Rails.application.load_tasks

# We use RSpec; remove Test::Unit tasks.
["test",
 "test:all",
 "test:all:db"].each do |task_name|
  Rake::Task[task_name].clear
end
