#
# Cookbook Name:: wawision
# Recipe:: app
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

app = node['wawision']

# Gracefully handle the failure for an invalid installation type
begin
  include_recipe "wawision::_app_#{app['install_method']}"
rescue Chef::Exceptions::RecipeNotFound
  raise Chef::Exceptions::RecipeNotFound, 'The install method ' \
    "`#{app['install_method']}` is not supported by this cookbook. " \
    'Please ensure you have spelled it correctly. If you continue to ' \
    'encounter this error, please file an issue.'
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
