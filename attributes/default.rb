default['ucarp']['vid'] = 1
default['ucarp']['password'] = 'sekret'
default['ucarp']['advskew'] = 1
default['ucarp']['advbase'] = 1
default['ucarp']['master'] = false
default['ucarp']['vip'] = '1.2.3.4'
default['ucarp']['netmask'] = '255.255.255.0'
default['ucarp']['interface'] = 'eth0'
default['ucarp']['bonded_interfaces'] = %w(eth0 eth1)
default['ucarp']['bond_mode'] = 5
default['ucarp']['init_type']  = value_for_platform(
  'centos' => {
    '~> 6.0' => 'upstart',
    '~> 7.0' => 'systemd'
  },
  'debian' => {
    '~> 8.0' => 'systemd'
  },
  'default' => 'upstart')
