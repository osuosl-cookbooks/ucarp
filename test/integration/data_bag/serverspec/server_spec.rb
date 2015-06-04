require 'serverspec'

set :backend, :exec

describe file('/etc/ucarp/vip-001.conf') do
  its(:content) { should match(/ID=001/) }
  its(:content) { should match(/BIND\_INTERFACE=eth0/) }
  its(:content) { should match(/SOURCE\_ADDRESS=127.0.0.1/) }
  its(:content) { should match(/VIP\_ADDRESS=192.0.2.4/) }
  its(:content) { should match(/PASSWORD=secret/) }
end
