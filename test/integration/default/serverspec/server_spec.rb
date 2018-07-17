require 'serverspec'

set :backend, :exec

describe package('ucarp') do
  it { should be_installed }
end

if os[:family] == 'redhat' && os[:release].to_i == 7
  describe file('/usr/libexec/ucarp/ucarp') do
    # Test for patched line for
    # https://bugzilla.redhat.com/show_bug.cgi?id=1568599
    its(:content) { should match(/^    FILES=`find \${CONFDIR} -maxdepth 1 -type f -name "\${_cfg}.conf" \\$/) }
    it { should be_mode 700 }
    it { should be_owned_by     'root' }
    it { should be_grouped_into 'root' }
  end
end
