require 'serverspec'

set :backend, :exec

describe package 'ucarp' do
  it { should_not be_installed }
end

describe service 'ucarp' do
  it { should_not be_enabled }
  it { should_not be_running }
end

%w(
  /usr/libexec/ucarp/ucarp
  /etc/ucarp/vip-001.conf
  /etc/ucarp/vip-001.pwd
). each do |f|
  describe file f do
    it { should_not exist }
  end
end
