#
# Cookbook Name:: wawision
# Attributes:: app
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

# See details for Attributes on:
# https://docs.getchef.com/attributes.html

default['wawision'].tap do |app|
  #
  # A short description of WaWision that will be used as a online comment on
  # different areas.
  #
  app['comment'] = 'ERP/CRM web application'

  #
  # The installation method - currently only +tar+ will be supported - in the
  # future it can be +package+ or +tar+. Then on RedHat and Debian platforms,
  # the installation method is to use the package from the official Apt/Yum
  # repos. On other platforms, the default method is using the tar file.
  #
  # node.set['wawision']['install_method'] = 'tar'
  #
  # app['install_method'] = case node['platform_family']
  #                         when 'debian', 'rhel' then 'package'
  #                         else 'tar'
  #                         end
  app['install_method'] = 'tar'

  #
  # The version of the WaWision package to install. This can be a specific
  # package version (from the yum or apt repo), or the version of the tar
  # file to download from the WaWision server.
  #
  app['version'] = '3.1-rc3'

  #
  # The server to donload the WaWision tar file. This attribute is only used
  # in the "tar" installation method.
  #
  # node.set['wawision']['server'] = 'http://cache.example.com'
  #
  # Note: this server is combined with some "smart" attributes to build the
  # WaWision tar. If you are not using an actual WaWision server, you might be
  # more interested in the +source+ attribute, which accepts the full path
  # to the tar file for downloading.
  #
  app['server'] = 'http://downloads.sourceforge.net'

  #
  # The full URL to the WaWision tar file on the remote server. This attribute
  # is only used in the "tar" installation method. This is a compiled attribute
  # from the +server+ and +version+ attributes, but you can override this
  # attribute and specify the full URL path to a remote file for the WaWision
  # tar file. If you choose to override this file manually, it is highly
  # recommended that you also set the +checksum+ attribute.
  #
  # node.set['wawision']['source'] = 'http://fs01.example.com/wawision.tar.gz'
  #
  # Warning: Setting this attribute will negate/ignore any values for +server+
  # and +version+.
  #
  app['source'] = "#{node['wawision']['server']}/project/wawision" \
    "/wawision_oss_testing-#{node['wawision']['version']}.tar.gz"

  #
  # The checksum of the tar file. This is use to verify that the remote tar file
  # has not been tampered with (such as a MITM attack). If you leave this
  # attribute set to +nil+, no validation will be performed. If this attribute
  # is set to the wrong SHA-256 checksum, the Chef Client run will fail.
  #
  # node.set['wawision']['checksum'] = 'abcd1234...'
  #
  app['checksum'] = \
    'a48df4938363d82ef7d362c8fdf519b8f65adcd1a95575c23fb7be623c8352ed'

  #
  # The username of the user who will own and run the WaWision application.
  # You can change this to any user on the system. Chef will automatically
  # create the user if it does not exist.
  #
  #   node.set['wawision']['user'] = 'root'
  #
  app['user'] = 'wawision'

  #
  # The group under which WaWision is running. WaWision doesn't actually use or
  # honor this attribute - it is used for file permission purposes.
  #
  app['group'] = 'wawision'

  #
  # WaWision user/group should be created as `system` accounts for `tar`
  # install. The default of `true` will ensure that **new** WaWision user
  # accounts are created in the system ID range, exisitng users will not
  # be modified.
  #
  #   node.set['wawision']['use_system_accounts'] = false
  #
  app['use_system_accounts'] = true

  #
  # The path to the WaWision home location. By default, this is the directory
  # where WaWision stores its runtime environment, configuration and static
  # data. You should ensure this directory resides on a volume with adequate
  # disk space.
  #
  app['home'] = '/var/lib/wawision'
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
