#
# Cookbook Name:: wawision
# Recipe:: _app_tar
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

include_recipe 'wawision::commons'

# See details for Standard Resource Types on:
# https://docs.getchef.com/resources.html

app = node['wawision']

# Create the WaWision user
user app['user'] do
  comment app['comment']
  shell '/bin/false'
  home app['home']
  system app['use_system_accounts'] # ~FC048
  action :create
end

# Create the WaWision group
group app['group'] do
  members app['user']
  system app['use_system_accounts'] # ~FC048
  action :create
end

# Lock the WaWision user
user app['user'] do
  action :lock
end

# Create the home directory
directory app['home'] do
  owner app['user']
  group app['group']
  mode '0755'
  recursive true
  action :create
end

# Download and extract the remote tar file
tar_extract app['source'] do
  checksum app['checksum'] if app['checksum']
  target_dir app['home']
  creates File.join(app['home'], 'www', 'index.php')
  user app['user']
  group app['group']
  tar_flags ['--strip-components 1']
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
