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

$LOAD_PATH.push(Pathname.new("../lib").expand_path(__FILE__).to_s)

require "asset_pages/version"

Gem::Specification.new do |s|
  s.name = "asset_pages"
  s.version = AssetPages::Version.to_s
  s.platform = Gem::Platform::RUBY
  s.licenses = ["Apache-2.0"]
  s.authors = ["Roy Liu"]
  s.email = ["carsomyr@gmail.com"]
  s.homepage = "https://github.com/carsomyr/asset_pages"
  s.summary = "Asset Pages is a library that augments the Jekyll static site generator with the Rails asset pipeline"
  s.description = "Asset Pages is a library that augments the Jekyll static site generator with the Rails asset" \
    " pipeline. Its collection of Jekyll plugins and Rake tasks constitute a workflow for precompiling and linking to" \
    " assets, as well as deploying the Jekyll-generated site to platforms like GitHub Pages. In terms of usability," \
    " Asset Pages aims to support Rails conventions: Structure your project as you would with a Rails app, but end up" \
    " with a static site and production-ready assets."
  s.add_runtime_dependency "jekyll", ">= 2.5.3"
  s.add_runtime_dependency "rails", ">= 4.2.0"
  s.add_runtime_dependency "rugged", ">= 0.22.0b5"
  s.add_runtime_dependency "uglifier", ">= 2.7.1"
  s.add_runtime_dependency "yui-compressor", ">= 0.12.0"
  s.files = (Pathname.glob("{app,config,lib,vendor}/**/*.rb") \
    + Pathname.glob("lib/tasks/**/*.rake") \
    + Pathname.glob("bin/*") \
  ).map { |f| f.to_s }
  s.test_files = Pathname.glob("{features,spec}/*").map { |f| f.to_s }
  s.executables = Pathname.glob("bin/*").map { |f| f.basename.to_s }
  s.require_paths = ["lib"]
end
