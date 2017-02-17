require_relative 'spec_helper'

describe 'ucarp::data_bag' do
  ALL_PLATFORMS.each do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.normal['ucarp']['data_bag']['cluster'] = 'lb1'
        node.normal['ucarp']['init_type'] = 'systemd'
      end.converge(described_recipe)
    end

    include_context 'common_stubs'

    it do
      expect { chef_run }.to_not raise_error
    end
  end
end
