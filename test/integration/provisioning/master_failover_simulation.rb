require 'chef/provisioning'
require 'chef/provisioning/vagrant_driver'

with_driver "vagrant:#{File.dirname(__FILE__)}/../../../vms"

vagrant_box 'bento/centos-7.3' do
  vagrant_provider 'virtualbox'
end

machine 'master' do
  chef_environment 'testing'
  role 'base'
  role 'base_managed'
  converge true
end

=begin
machine_batch do
  [%w(master 41), %w(failover 43)].each do |name, ip_suffix|
    machine name do
      add_machine_options vagrant_options: {
        'vm.box' => 'bento/centos-7.3',
        #'vm.box_version' => '2.2.9',
        #'vm.hostname' => "#{name}-lb"
        'vm.network' => [
          ":private_network, {ip: 192.168.60.#{ip_suffix}}",
        ]
      },

      vagrant_provider: 'virtualbox',
         convergence_options: {
         chef_version: '12.18.31'
      }

      role 'base_managed'
      role 'base'
      role 'haproxy_osuosl'
      recipe 'ucarp::default'

      file('/etc/chef/encrypted_data_bag_secret',
           File.dirname(__FILE__) +
           '/../encrypted_data_bag_secret')
      converge true
    end
  end
end
=end
