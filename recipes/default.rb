#
# Cookbook Name:: ucarp
# Recipe:: default
#
# Copyright 2012, Eric Heydrick
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

include_recipe 'yum-epel' if platform_family?('rhel')

package 'ucarp'

# Overwrite packaged file to address bug:
# https://bugzilla.redhat.com/show_bug.cgi?id=1568599
cookbook_file '/usr/libexec/ucarp/ucarp' do
  source 'ucarp'
  owner 'root'
  group 'root'
  mode '0700'
  only_if { platform_family?('rhel') && node['platform_version'].to_i == 7 } # CentOS 7
end
