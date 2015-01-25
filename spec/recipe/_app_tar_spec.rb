#
# Cookbook Name:: wawision
# Spec:: _app_tar_spec
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
# examples, shared over local tests
#

#
# Usage:
#
#   include_examples 'creates user and group', false do # or true
#     let(:comment) { '__YOUR_USER_COMMENT__' }
#     let(:user)    { '__YOUR_USER_NAME__' }
#     let(:group)   { '__YOUR_GROUP_NAME__' }
#     let(:shell)   { '__YOUR_LOGIN_SHELL_NAME__' }
#     let(:home)    { '__YOUR_HOME_DIR_NAME__' }
#   end
#
shared_examples_for 'creates user and group' do |system|
  it "creates the user (system account is #{system})" do
    expect(chef_run).to create_user(user)
      .with_comment(comment)
      .with_shell(shell)
      .with_home(home)
      .with_system(system)
  end

  it "creates the group (system account is #{system})" do
    expect(chef_run).to create_group(group)
      .with_members([user])
      .with_system(system)
  end

  it "locks the created user (system account is #{system})" do
    expect(chef_run).to lock_user(user)
  end
end

#
# Usage:
#
#   let(:user)     { '__YOUR_USER_NAME__' }
#   let(:group)    { '__YOUR_GROUP_NAME__' }
#   let(:home)     { '__YOUR_HOME_DIR_NAME__' }
#   let(:dirmode)  { '__YOUR_HOME_DIR_MODE__' }
#   let(:source)   { '__YOUR_REMOTE_FILE_SOURCE__' }
#   let(:checksum) { '__YOUR_REMOTE_FILE_CHECKSUM__' }
#   let(:creates)  { '__YOUR_EXPECTED_FILE_NAME__' }
#
#   include_examples 'extract remote source to home'
#
shared_examples_for 'extract remote source to home' do
  it 'creates the home directory' do
    expect(chef_run).to create_directory(home)
      .with_owner(user)
      .with_group(group)
      .with_mode(dirmode)
      .with_recursive(true)
  end

  it 'extract the remote tar file' do
    expect(chef_run).to extract_tar_extract(source)
      .with_checksum(checksum)
      .with_target_dir(home)
      .with_creates(creates)
      .with_user(user)
      .with_group(group)
      .with_tar_flags(['--strip-components 1'])
  end
end

###############################################################################
#
# tests recipe inclusion, shared over all supported platforms
#
shared_examples '_app_tar_recipes' do |platform, version|
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
    )
  end
end

###############################################################################
#
# tests with node defaults, shared over all supported platforms
#
shared_examples '_app_tar_defaults' do |platform, version|
  context "on #{platform} #{version} with defaults" do
    property = load_platform_properties(
      platform: platform,
      platform_version: version
    )

    app = property[:wawision]

    let(:source)   { "#{app[:source]}" }
    let(:checksum) { "#{app[:checksum]}" }
    let(:comment)  { "#{app[:comment]}" }

    let(:user)     { "#{app[:user]}" }
    let(:group)    { "#{app[:group]}" }
    let(:shell)    { '/bin/false' }
    let(:home)     { "#{app[:home]}" }
    let(:dirmode)  { "0#{app[:dirmode]}" }

    let(:creates)  { "#{home}/www/index.php" }

    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: platform, version: version)
        .converge(described_recipe)
    end
    subject { chef_run }

    before do
      # as long as we want to test the single recipe
      # we have to resolve all other ressources
      allow_any_instance_of(Chef::Recipe).to receive(:include_recipe)
    end

    context 'install application from source tar' do
      use_system_accounts = app[:use_system_accounts]
      include_examples 'creates user and group', use_system_accounts
      include_examples 'extract remote source to home'
    end
  end
end

###############################################################################
#
# tests with node overrides, shared over all supported platforms
#
shared_examples '_app_tar_overrides' do |platform, version|
  context "on #{platform} #{version} with overrides" do
    property = load_platform_properties(
      platform: platform,
      platform_version: version
    )

    app = property[:wawision]

    let(:source)   { 'ftp://ham.butchers.shop:4711/spam' }
    let(:checksum) { '0815' }
    let(:comment)  { 'a horse from moon' }

    let(:user)     { 'gromit' }
    let(:group)    { 'pet' }
    let(:shell)    { '/bin/false' }
    let(:home)     { '/shop/butchers/ham' }
    let(:dirmode)  { "0#{app[:dirmode]}" }

    let(:creates)  { "#{home}/www/index.php" }

    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: platform, version: version) do |node|
        node.set['wawision']['source'] = 'ftp://ham.butchers.shop:4711/spam'
        node.set['wawision']['checksum'] = '0815'
        node.set['wawision']['comment'] = 'a horse from moon'
        node.set['wawision']['user'] = 'gromit'
        node.set['wawision']['group'] = 'pet'
        node.set['wawision']['use_system_accounts'] = false
        node.set['wawision']['home'] = '/shop/butchers/ham'
      end.converge(described_recipe)
    end
    subject { chef_run }

    before do
      # as long as we want to test the single recipe
      # we have to resolve all other ressources
      allow_any_instance_of(Chef::Recipe).to receive(:include_recipe)
    end

    context 'install application from source tar' do
      use_system_accounts = false
      include_examples 'creates user and group', use_system_accounts
      include_examples 'extract remote source to home'
    end
  end
end

###############################################################################
#
# raises an exception test, shared over all unsupported platforms
#
shared_examples '_app_tar_unsupported' do |platform, version|
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
describe 'wawision::_app_tar' do
  # Test on all supported platforms
  supported_platforms.each do |platform, versions|
    versions.each do |version|
      include_examples '_app_tar_recipes', platform, version
      include_examples '_app_tar_defaults', platform, version
      include_examples '_app_tar_overrides', platform, version
    end
  end

  # Test on all unsupported platforms
  unsupported_platforms.each do |platform, versions|
    versions.each do |version|
      include_examples '_app_tar_unsupported', platform, version
    end
  end
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
