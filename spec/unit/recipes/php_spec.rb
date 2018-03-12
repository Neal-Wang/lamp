#
# Cookbook:: lamp
# Spec:: default
#
# Copyright:: 2018, IBPort, All Rights Reserved.

require 'spec_helper'

describe 'lamp::php' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    php_modules = %w(curl date gd json mbstring mysql xml fpm soap pear mcrypt mysql)

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should update apt' do
      expect(chef_run).to update_apt_update('update_apt')
    end

    it 'should include php recipe' do
      expect(chef_run).to include_recipe('php')
    end

    it "should install php modules #{php_modules.join(', ')}" do
      php_modules.each do |mod|
        expect(chef_run).to install_package("php-#{mod}")
      end
    end
  end
end
