#
# Cookbook Name:: wawision
# Build:: metadata
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

# See details for Chef Metadata Syntax on:
# https://docs.getchef.com/config_rb_metadata.html

name 'wawision'
version '0.1.0'

license 'Apache 2.0'

maintainer 'Stephan Linz'
maintainer_email 'linz@li-pro.net'

description 'Installs/Configures WaWision'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

%w(
  debian
  ubuntu
  centos
  redhat
  oracle
  amazon
).each do |os|
  supports os
end

%w(
  tar
).each do |cb|
  depends cb
end

recipe 'default', 'Does run app recipe as default.'
recipe 'app', 'Dumps chef node data to json file.'

provides 'wawision'

attribute 'wawision/install_method',
  display_name: 'WaWision installation method',
  description: 'The installation method to use.',
  type: 'string',
  default: 'tar'

attribute 'wawision/version',
  display_name: 'WaWision package version',
  description: 'The version of the WaWision package to install.',
  type: 'string',
  default: '3.1-rc3'

attribute 'wawision/server',
  display_name: 'WaWision installation server',
  description: 'The server to donload the WaWision package file.',
  type: 'string',
  default: 'http://downloads.sourceforge.net'

attribute 'wawision/source',
  display_name: 'WaWision installation source',
  description: 'The full URL to the WaWision package file.',
  type: 'string'

attribute 'wawision/checksum',
  display_name: 'WaWision package checksum',
  description: 'The checksum of the package file.',
  type: 'string'

attribute 'wawision/user',
  display_name: 'WaWision installation username',
  description: 'The name of the user who will own and run WaWision.',
  type: 'string',
  default: 'wawision'

attribute 'wawision/group',
  display_name: 'WaWision installation groupname',
  description: 'The name of the group who will own and run WaWision.',
  type: 'string',
  default: 'wawision'

attribute 'wawision/use_system_accounts',
  display_name: 'WaWision usr/group system flag',
  description: 'The user/group should be created as `system` account.',
  type: 'boolean',
  default: true

attribute 'wawision/home',
  display_name: 'WaWision installation and home directory',
  description: 'The path to the WaWision home location.',
  type: 'string',
  default: '/var/lib/wawision'

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
