require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start! { add_filter 'ucarp' }

CENTOS_7 = {
  platform: 'centos',
  version: '7.3',
  platform_family: 'rhel'
}.freeze

CENTOS_6 = {
  platform: 'centos',
  version: '6.8',
  platform_family: 'rhel'
}.freeze

DEBIAN_8 = {
  platform: 'debian',
  version: '8.4'
}.freeze

ALL_PLATFORMS = [
  CENTOS_6,
  CENTOS_7,
  DEBIAN_8
].freeze

RSpec.configure do |config|
  config.log_level = :fatal
end

shared_context 'common_stubs' do
  before do
    stub_command 'ip addr flush dev eth0'
    stub_command 'ip addr flush dev eth1'
    stub_command 'flush ip on eth0'
    stub_command 'flush ip on eth1'

    stub_data_bag_item('ucarp', 'lb1').and_return(
      id: 'vip-lb1',
      vip_id: '001',
      vip_address: '192.0.2.4',
      bind_interface: 'eth0',
      password: 'secret'
    )
  end
end
