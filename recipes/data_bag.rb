#
# Cookbook Name:: ucarp
# Recipe:: data_bag
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

include_recipe 'ucarp'

begin
  ucarp_databag = data_bag_item('ucarp', node['ucarp']['data_bag']['cluster'])
rescue
  raise "Could not find data bag for #{node['ucarp']['data_bag']['cluster']}"
end

if platform_family?('rhel')
  template "/etc/ucarp/vip-#{ucarp_databag['vip_id']}.conf" do
    source 'vip.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables ucarp_databag.to_hash
    notifies :restart, 'service[ucarp]'
  end

  paths = %w(/etc/systemd/system /etc/systemd/system/multi-user.target.wants)

  service 'ucarp' do
    case node['ucarp']['init_type']
    when 'systemd'
      provider Chef::Provider::Service::Systemd
      service_name "ucarp@vip-#{ucarp_databag['vip_id']}.service"
    end
    supports status: true, restart: true
    action [:start, :enable]
  end
end
