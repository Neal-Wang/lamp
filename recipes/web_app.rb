#
# Cookbook:: lamp
# Recipe:: web_app
#
# Copyright:: 2018, IBPort, All Rights Reserved.

directory node['lamp']['web_app']['docroot'] do
  owner node['apache']['user']
  group node['apache']['group']
  recursive true
  action :create
end

cookbook_file "#{node['lamp']['web_app']['docroot']}/#{node['lamp']['web_app']['directory_index']}" do
  owner node['apache']['user']
  group node['apache']['group']
  action :create_if_missing
end

web_app node['lamp']['web_app']['name'] do
  template 'web_app.conf.erb'
  server_name node['lamp']['web_app']['server_name']
  docroot node['lamp']['web_app']['docroot']
  directory_index node['lamp']['web_app']['directory_index']
  allow_override node['lamp']['web_app']['allow_override']
  cookbook 'apache2'
end