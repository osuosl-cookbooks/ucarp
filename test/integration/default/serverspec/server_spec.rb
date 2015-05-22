require 'serverspec'

set :backend, :exec

describe package('ucarp') do
  it { should be_installed }
end

describe service('ucarp') do
  it { shoule be_enabled }
end