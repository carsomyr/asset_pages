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

require "fileutils"
require "rugged"
require "yaml"
require "asset_pages/util"

namespace :gh_pages do
  desc "Build the site, commit it along with GitHub Pages metadata, and push it to GitHub"
  task push: "asset_pages:precompile" do
    dest_dir = Pathname.new("_#{Rails.env}")

    # Touch the `.nojekyll` file, since we precompiled everything.
    FileUtils.touch(dest_dir + ".nojekyll")

    jekyll_config = AssetPages::Util.jekyll_config
    project_cname = AssetPages::Util.fetch_nested(jekyll_config, "asset_pages", "gh_pages", "cname")

    # Did a user provide a custom domain name? If so, write out the CNAME file.
    (dest_dir + "CNAME").open("wb") { |f| f.write("#{project_cname}\n") } \
      if project_cname

    repo = Rugged::Repository.init_at(dest_dir.to_s)
    main_repo = Rugged::Repository.new(".")
    main_repo_origin = main_repo.remotes["origin"]

    repo_path_pattern = Regexp.new("[/:]([a-zA-Z_0-9\\-]+)/\\1\\.github\\.(?:com|io)\\z")

    # Guess the target branch based on the `origin` remote's URL.
    if !repo_path_pattern.match(main_repo_origin.url)
      branch_name = "gh-pages"
    else
      branch_name = "master"
    end

    index = repo.index

    # These glob patterns should pick up everything.
    index.remove_all(["*", ".*"])
    index.write
    index.add_all(["*", ".*"])
    index.write

    # Write the index to a tree object for committing.
    tree = index.write_tree

    # Have commits write to the branch.
    repo.references.update("HEAD", "refs/heads/#{branch_name}")

    # Derive the author information from the main repository's HEAD.
    author = main_repo.head.target.author
    repo.config["user.name"] = author[:name]
    repo.config["user.email"] = author[:email]

    # Create the commit with the given tree object.
    if !repo.head_unborn?
      repo.head.target.amend(
          update_ref: "HEAD",
          tree: tree
      )
    else
      Rugged::Commit.create(
          repo,
          message: "asset_pages: Automated GitHub Pages build",
          parents: [],
          update_ref: "HEAD",
          tree: tree
      )
    end

    # Shell out to `git` for pushing.
    Dir.chdir(dest_dir) do
      sh "git", "push", "--force", "--", main_repo_origin.url, branch_name
    end
  end
end
