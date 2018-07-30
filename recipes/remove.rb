#
# Cookbook:: ucarp
# Recipe:: remove
#
# Copyright:: 2018, Oregon State University
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

ucarp_databag = begin
                  data_bag_item('ucarp', node['ucarp']['data_bag']['cluster'])
                rescue
                  nil
                end

unless ucarp_databag.nil?
  # Prevent notifications from restarting service after it's already been removed
  pwd_r  = find_resource(:file,     "/etc/ucarp/vip-#{ucarp_databag['vip_id']}.pwd")
  conf_r = find_resource(:template, "/etc/ucarp/vip-#{ucarp_databag['vip_id']}.conf")
  run_context.delayed_notification_collection.delete(pwd_r.declared_key)
  run_context.delayed_notification_collection.delete(conf_r.declared_key)

  edit_resource(:file, "/etc/ucarp/vip-#{ucarp_databag['vip_id']}.pwd") do
    action :delete
  end

  edit_resource(:template, "/etc/ucarp/vip-#{ucarp_databag['vip_id']}.conf") do
    action :delete
  end
end

edit_resource(:service, 'ucarp') do
  action [:stop, :disable]
end

edit_resource(:package, 'ucarp') do
  action :remove
end

# Remove patched file
edit_resource(:cookbook_file, '/usr/libexec/ucarp/ucarp') do
  action :delete
end
