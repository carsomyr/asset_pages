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

require "jekyll/static_file"

module Jekyll
  class StaticFile
    attr_reader :site
    attr_reader :base
    attr_reader :dir
    attr_reader :name

    def ==(o)
      @site == o.site \
        && @base == o.base \
        && @dir == o.dir \
        && @name == o.name
    end

    alias_method :eql?, :==

    def hash
      @site.hash ^ @base.hash ^ @dir.hash ^ @name.hash
    end
  end
end
