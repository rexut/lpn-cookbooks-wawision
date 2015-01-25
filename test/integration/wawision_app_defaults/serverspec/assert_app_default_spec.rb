#
# Cookbook Name:: wawision
# Test:: assert_app_default_spec
#
# Author:: Stephan Linz <linz@li-pro.net>
#
# Copyright:: 2015, Li-Pro.Net
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "#{ENV['BUSSER_ROOT']}/../kitchen/data/spec_helper"

# See details for Standard Resource Types on:
# http://serverspec.org/resource_types.html

# See details for Custom Resource Types on:
# http://www.tuicool.com/articles/beiaEbv

describe 'app::default' do
  app = property[:wawision]

  context user("#{app[:user]}").to_s + ' and ' + group("#{app[:group]}").to_s do
    use_system_accounts = app[:use_system_accounts]
    include_examples 'a user belongs group and home', use_system_accounts do
      let(:usr) { app[:user] }
      let(:grp) { app[:group] }
      let(:lsh) { '/bin/false' }
      let(:hme) { app[:home] }
    end
  end

  context file("#{app[:home]}") do
    include_examples 'a directory' do
      let(:drn) { app[:home] }
      let(:dmd) { app[:dirmode] }
      let(:usr) { app[:user] }
      let(:grp) { app[:group] }
    end
  end

  context file("#{app[:home]}/version.php") do
    include_examples 'a wawision oss testing revision' do
      let(:fln) { "#{app[:home]}/version.php" }
      let(:fmd) { '644' }
      let(:usr) { app[:user] }
      let(:grp) { app[:group] }
      let(:rev) { app[:ossrev] }
    end
  end

  context file("#{app[:home]}/www/index.php") do
    include_examples 'a file' do
      let(:fln) { "#{app[:home]}/www/index.php" }
      let(:fmd) { '755' } # TODO: fix file mode in converge
      let(:usr) { app[:user] }
      let(:grp) { app[:group] }
    end
  end
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
