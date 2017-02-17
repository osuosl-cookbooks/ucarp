require_relative 'spec_helper'

describe 'ucarp::default' do
  ALL_PLATFORMS.each do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.normal['platform_family'] = 'rhel'
      end.converge(described_recipe)
    end

    context 'on both rhel and non-rhel distros' do
      it do
        expect(chef_run).to install_package('ucarp')
      end
    end

    it do
      resource = chef_run.service('networking')
      expect(resource).to do_nothing
    end

    it do
      template_resource = chef_run.template('/etc/network/interfaces')
      expect(template_resource).to notify(
        'service[networking]'
      ).to(:restart).immediately
    end
  end
end
