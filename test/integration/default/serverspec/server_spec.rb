require 'serverspec'

set :backend, :exec

describe package('ucarp') do
  it { should be_installed }
end

describe service('ucarp') do
  it { should be_enabled }
end
