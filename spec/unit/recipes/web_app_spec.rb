#
# Cookbook:: lamp
# Spec:: default
#
# Copyright:: 2018, IBPort, All Rights Reserved.

require 'spec_helper'

describe 'lamp::web_app' do
  context 'on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
        node.override['lamp']['web_app']['writable_dirs'] = ['cache', 'tmp', 'logs']
        node.override['lamp']['web_app']['writable_files'] = ['logs/app.log']
        node.override['lamp']['web_app']['deploy_key_type'] = 'ssh-rsa'
        node.override['lamp']['web_app']['deploy_key'] = 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCfXeuJ8T6ASzJUC0x1VQctUH3Y66RW9iOtUo8pHNJ6hP2PmcKWzaNPkGFFzcwzny/c1lz/GJ44/ebJbBEu8r2RlwumAUBwKYzyrrbU0HeWvZflNd9ZjETYkfEl7YhuiD79WsnSxWjGzgRnBTYGe2GeinsuK3mTvoDfDt2gWCZpYai5rrPUOw+OFkeAvZSMKVTIiFY9wCkjgRfIU2swbXl1OPKIcV+/TDE0p2On9oH+cDFudscGsGBdIwExyvcxyYnWtBpFfeoMti+nIJH1JgKeoEdxnyslh5FOzlQkm+oM+KYf/f3Rg+bR40oduPrItWXwjV/aT+keOuvhr7t7f4af'
        node.override['lamp']['web_app']['deploy_key_comment'] = 'Admin@OPTI990-068'
      end
      runner.converge(described_recipe)
    end

    before do
      stub_command('/usr/sbin/apache2 -t').and_return(false)
    end

    base_dir = '/var/www/slimsample'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should create user deploy' do
      expect(chef_run).to create_user('deploy').with(
        manage_home: true, home: '/home/deploy', shell: '/bin/bash')
    end

    it 'should create group deploy with a user deploy' do
      expect(chef_run).to create_group('deploy').with(members: ['deploy'])
    end

    it 'should add authorized key' do
      expect(chef_run).to add_ssh_authorized_keys('deploy_key').with(
        user: 'deploy', type: 'ssh-rsa', comment: 'Admin@OPTI990-068',
        key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCfXeuJ8T6ASzJUC0x1VQctUH3Y66RW9iOtUo8pHNJ6hP2PmcKWzaNPkGFFzcwzny/c1lz/GJ44/ebJbBEu8r2RlwumAUBwKYzyrrbU0HeWvZflNd9ZjETYkfEl7YhuiD79WsnSxWjGzgRnBTYGe2GeinsuK3mTvoDfDt2gWCZpYai5rrPUOw+OFkeAvZSMKVTIiFY9wCkjgRfIU2swbXl1OPKIcV+/TDE0p2On9oH+cDFudscGsGBdIwExyvcxyYnWtBpFfeoMti+nIJH1JgKeoEdxnyslh5FOzlQkm+oM+KYf/f3Rg+bR40oduPrItWXwjV/aT+keOuvhr7t7f4af')
    end

    it 'should create /var/www/slimsample' do
      expect(chef_run).to create_directory('/var/www/slimsample').with(
        owner: 'deploy', group: 'deploy', mode: '0755', recursive: true)
    end

    it 'should create /var/www/slimsample/public' do
      expect(chef_run).to create_directory('/var/www/slimsample/public').with(
        owner: 'deploy', group: 'deploy', mode: '0755', recursive: true)
    end

    it 'should create writable directories' do
      ['cache', 'tmp', 'logs'].each do |writable_dir|
        expect(chef_run).to create_directory(File.join(base_dir, writable_dir)).with(
          owner: 'www-data', group: 'www-data', mode: '0755', recursive: true)
      end
    end

    it 'should create writable files' do
      ['logs/app.log'].each do |writable_file|
        expect(chef_run).to create_file_if_missing(File.join(base_dir, writable_file)).with(
          owner: 'www-data', group: 'www-data', mode: '0644')
      end
    end

    it 'should create file /var/www/slimsample/public/index.php if missing' do
      expect(chef_run).to create_cookbook_file_if_missing('/var/www/slimsample/public/index.php').with(
        owner: 'deploy', group: 'deploy', mode: '0644')
    end
  end
end
