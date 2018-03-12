#
# Cookbook:: lamp
# Spec:: default
#
# Copyright:: 2018, IBPort, All Rights Reserved.

require 'spec_helper'

describe 'lamp::web_app' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    before do
      stub_command('/usr/sbin/apache2 -t').and_return(false)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should create /var/www/slimsample/public' do
      expect(chef_run).to create_directory('/var/www/slimsample/public').with(
        owner: 'www-data', group: 'www-data', recursive: true)
    end

    it 'should create file /var/www/slimsample/public/index.php if missing' do
      expect(chef_run).to create_cookbook_file_if_missing('/var/www/slimsample/public/index.php').with(
        owner: 'www-data', group: 'www-data')
    end
  end
end
