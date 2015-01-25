#
# Cookbook Name:: wawision
# Spec:: app_spec
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

require 'spec_helper'

# See details for Standard Resource Types on:
# https://docs.getchef.com/chefspec.html

# See details for Tar Resource Types on:
# https://github.com/gofullstack/tar-cookbook/blob/master/libraries/matchers.rb

###############################################################################
#
# tests recipe inclusion, shared over all supported platforms
#
shared_examples 'app_recipes' do |platform, version|
  context "on #{platform} #{version} with recipes" do
    _property = load_platform_properties(
      platform: platform,
      platform_version: version
    )

    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: platform, version: version)
        .converge(described_recipe)
    end
    subject { chef_run }

    include_examples 'supported platform' do
      let(:pn) { platform }
      let(:pv) { version }
    end

    include_examples 'included recipes', %w(
      wawision::commons
      wawision::commons_os
      wawision::_app_tar
    )
  end
end

###############################################################################
#
# tests with node defaults, shared over all supported platforms
#
shared_examples 'app_defaults' do |platform, version|
  context "on #{platform} #{version} with defaults (valid install method)" do
    property = load_platform_properties(
      platform: platform,
      platform_version: version
    )

    app = property[:wawision]

    let(:install_method) { "#{app[:install_method]}" }

    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: platform, version: version)
        .converge(described_recipe)
    end
    subject { chef_run }

    include_examples 'raises no error on equal' do
      let(:v1) { install_method }
      let(:v2) { chef_run.node['wawision']['install_method'] }
    end
  end
end

###############################################################################
#
# tests with node overrides, shared over all supported platforms
#
shared_examples 'app_overrides' do |platform, version|
  context "on #{platform} #{version} with overrides (invalid install method)" do
    _property = load_platform_properties(
      platform: platform,
      platform_version: version
    )

    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: platform, version: version) do |node|
        node.set['wawision']['install_method'] = 'invalid'
      end.converge(described_recipe)
    end
    subject { chef_run }

    include_examples 'raises an recipe not found error' do
      let(:eem) do
        'The install method `invalid` is not supported by this cookbook. ' \
        'Please ensure you have spelled it correctly. If you continue to ' \
        'encounter this error, please file an issue.'
      end
    end
  end
end

###############################################################################
#
# raises an exception test, shared over all unsupported platforms
#
shared_examples 'app_unsupported' do |platform, version|
  context "on #{platform} #{version} (unsupported)" do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: platform, version: version)
        .converge(described_recipe)
    end
    subject { chef_run }

    include_examples 'unsupported platform' do
      let(:pn) { platform }
      let(:pv) { version }
    end
  end
end

###############################################################################
#
# platform overrun
#
describe 'wawision::app' do
  # Test on all supported platforms
  supported_platforms.each do |platform, versions|
    versions.each do |version|
      include_examples 'app_recipes', platform, version
      include_examples 'app_defaults', platform, version
      include_examples 'app_overrides', platform, version
    end
  end

  # Test on all unsupported platforms
  unsupported_platforms.each do |platform, versions|
    versions.each do |version|
      include_examples 'app_unsupported', platform, version
    end
  end
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
