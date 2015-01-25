#
# Cookbook Name:: wawision
# Test:: shared_examples_app
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

#
# Usage:
#
#   include_examples 'a wawision oss testing revision' do
#     let(:fln) { '__YOUR_VERSION_FILE_NAME__' }
#     let(:fmd) { '__YOUR_VERSION_FILE_MODE__' }
#     let(:usr) { '__YOUR_USER_NAME__' }
#     let(:grp) { '__YOUR_GROUP_NAME__' }
#     let(:rev) { '__YOUR_REVISION_NUMBER__' }
#   end
#
shared_examples_for 'a wawision oss testing revision' do
  include_examples 'a file'

  context 'WaWision OSS testing release' do
    it 'file exists and has valid version' do
      expect(file(fln)).to be_file
      expect(file(fln)).to contain('oss_testing')
        .from(/\$version.*=.*[",']/)
        .to(/[",'].*;.*$/)
    end

    it 'file exists and has valid revision' do
      expect(file(fln)).to be_file
      expect(file(fln)).to contain(rev)
        .from(/\$version_revision.*=.*[",']/)
        .to(/[",'].*;.*$/)
    end
  end
end

# vim: ts=2 sts=2 sw=2 ai si et ft=ruby
