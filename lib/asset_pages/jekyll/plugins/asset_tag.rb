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
require "liquid"
require "asset_pages/jekyll/liquid_helper"

module Jekyll
  class AssetTag < Liquid::Tag
    include AssetPages::Jekyll::LiquidHelper

    SourcePattern = Regexp.new("#{Liquid::QuotedFragment}+")

    attr_reader :sources
    attr_reader :options

    def initialize(name, markup, tokens)
      super

      @sources = []
      @options, markup = AssetTag.parse_options(markup)

      markup.scan(SourcePattern) do |path|
        sources.push(path)
      end
    end

    def render(context)
      @context = context
    end

    def self.parse_options(markup)
      options = {}

      markup = markup.gsub(Liquid::TagAttributes) do |matched|
        attr_name = $1
        attr_value = $2

        raise ArgumentError, "Please qualify the attribute value #{attr_value.dump} with quotes" \
          if !(attr_value.size >= 2 && attr_value[0] == "\"" && attr_value[-1] == "\"")

        options[attr_name] = attr_value[1...-1]

        ""
      end

      [options, markup]
    end
  end
end
