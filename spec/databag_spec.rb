require_relative 'spec_helper'

describe 'ucarp::data_bag' do
  ALL_PLATFORMS.each do |plat|
    context "#{plat[:platform]} #{plat[:version]}" do
      cached(:chef_run) do
        ChefSpec::SoloRunner.new(plat) do |node|
          node.normal['ucarp']['data_bag']['cluster'] = 'lb1'
          node.normal['ucarp']['init_type'] = 'systemd'
        end.converge(described_recipe)
      end

      include_context 'common_stubs'

      it do
        expect { chef_run }.to_not raise_error
      end
      it do
        expect(chef_run).to create_file('/etc/ucarp/vip-001.pwd').with(
          content: 'secret',
          owner: 'root',
          group: 'root',
          mode: '0400'
        )
      end
      it do
        expect(chef_run.file('/etc/ucarp/vip-001.pwd')).to notify('service[ucarp]').to(:restart)
      end
      it do
        expect(chef_run).to create_template('/etc/ucarp/vip-001.conf').with(
          source: 'vip.conf.erb',
          owner: 'root',
          group: 'root',
          mode: '0644'
        )
      end
      it do
        expect(chef_run.template('/etc/ucarp/vip-001.conf')).to notify('service[ucarp]').to(:restart)
      end
      it do
        expect(chef_run).to start_service('ucarp').with(
          supports: { status: true, restart: true }
        )
      end
      it do
        expect(chef_run).to enable_service('ucarp').with(
          supports: { status: true, restart: true }
        )
      end
    end
  end
end
