#
# Cookbook:: lamp
# Recipe:: database
#
# Copyright:: 2018, IBPort, All Rights Reserved.

mysql_client 'default' do
  action :create
end

mysql2_chef_gem 'default' do
  action :install
end

mysql_service node['lamp']['database']['instance_name'] do
  port node['lamp']['database']['port']
  version node['lamp']['database']['version']
  initial_root_password node['lamp']['database']['root_password']
  action [:create, :start]
end

socket = "/var/run/mysql-#{node['lamp']['database']['instance_name']}/mysqld.sock"

link '/var/run/mysqld/mysqld.sock' do
  to socket
  not_if 'test -f /var/run/mysqld/mysqld.sock'
end

mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :socket   => socket,
  :password => node['lamp']['database']['root_password']
}

mysql_database node['lamp']['database']['name'] do
  connection mysql_connection_info
  action :create
end

mysql_database_user node['lamp']['database']['user'] do
  connection mysql_connection_info
  password node['lamp']['database']['password']
  host node['lamp']['database']['host']
  database_name node['lamp']['database']['name']
  privileges [:all]
  action [:create, :grant]
end