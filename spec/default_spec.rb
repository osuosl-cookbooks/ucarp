require_relative 'spec_helper'

describe 'ucarp::default' do
  ALL_PLATFORMS.each do |plat|
    context "#{plat[:platform]} #{plat[:version]}" do
      cached(:chef_run) do
        ChefSpec::SoloRunner.new(plat).converge(described_recipe)
      end
      it do
        expect(chef_run).to install_package('ucarp')
      end
      if plat[:version].to_i == 7
        it do
          expect(chef_run).to create_cookbook_file('/usr/libexec/ucarp/ucarp').with(
            source: 'ucarp',
            owner: 'root',
            group: 'root',
            mode: '0700'
          )
        end
      end
    end
  end
end
