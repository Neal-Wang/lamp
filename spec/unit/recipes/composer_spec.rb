#
# Cookbook:: lamp
# Spec:: default
#
# Copyright:: 2018, IBPort, All Rights Reserved.

require 'spec_helper'

describe 'lamp::composer' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    before do
      stub_command("php -m | grep 'Phar'").and_return(false)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should include recipe composer' do
      expect(chef_run).to include_recipe('composer')
    end
  end
end
