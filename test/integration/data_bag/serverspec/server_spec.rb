require 'serverspec'

set :backend, :exec

describe file('/etc/ucarp/vip-001.conf') do
  its(:content) { should match(/ID=001/) }
  its(:content) { should match(/BIND\_INTERFACE=eth0/) }
  its(:content) { should match(/SOURCE\_ADDRESS=127.0.0.1/) }
  its(:content) { should match(/VIP\_ADDRESS=192.0.2.4/) }
  its(:content) { should match(/PASSWORD=secret/) }
end

describe file('/etc/ucarp/vip-001.pwd') do
  its(:content) { should match(/secret/) }
  it { should be_owned_by     'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 400 }
end

describe package('ucarp') do
  it { should be_installed }
end

service_name = 'ucarp@vip-001' if os[:family] == 'redhat' && os[:release].to_i == 7
service_name = 'ucarp'         if os[:family] == 'redhat' && os[:release].to_i == 6

describe service service_name do
  it { should be_enabled }
  it { should be_running }
end
