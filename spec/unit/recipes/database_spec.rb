#
# Cookbook:: lamp
# Spec:: default
#
# Copyright:: 2018, IBPort, All Rights Reserved.

require 'spec_helper'

describe 'lamp::database' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    before do
      stub_command('test -f /var/run/mysqld/mysqld.sock').and_return(false)
    end

    socket = '/var/run/mysql-default/mysqld.sock'
    mysql_connection_info = {
      :host     => 'localhost',
      :username => 'root',
      :socket   => socket,
      :password => 'ibportrnd153'
    }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should create mysql_client default' do
      expect(chef_run).to create_mysql_client('default')
    end

    it 'should install mysql2_chef_gem default' do
      expect(chef_run).to install_mysql2_chef_gem('default')
    end

    it 'should create and start mysql_service default' do
      expect(chef_run).to create_mysql_service('default').with(
        port: 3306, version: '5.7',
        initial_root_password: 'ibportrnd153', action: [:create, :start])
    end

    it "should create link /var/run/mysqld/mysqld.sock to #{socket}" do
      expect(chef_run).to create_link('/var/run/mysqld/mysqld.sock').with(
        to: socket)
    end

    it 'should create mysql_database slimsampledb' do
      expect(chef_run).to create_mysql_database('slimsampledb').with(
        connection: mysql_connection_info)
    end

    it 'should create and grant mysql_database_user slimsampleuser' do
      expect(chef_run).to create_mysql_database_user('slimsampleuser').with(
        connection: mysql_connection_info, host: 'localhost',
        password: 'slimsamplepw')
      expect(chef_run).to grant_mysql_database_user('slimsampleuser').with(
        connection: mysql_connection_info, database_name: 'slimsampledb',
        privileges: [:all])
    end
  end
end
