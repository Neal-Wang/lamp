#
# Cookbook:: lamp
# Recipe:: web_app
#
# Copyright:: 2018, IBPort, All Rights Reserved.

home_dir = "/home/#{node['lamp']['web_app']['deploy_user']}"

user node['lamp']['web_app']['deploy_user'] do
  manage_home true
  home home_dir
  shell '/bin/bash'
  action :create
end

group node['lamp']['web_app']['deploy_group'] do
  members [node['lamp']['web_app']['deploy_user']]
  action :create
end

ssh_authorized_keys 'deploy_key' do
  user node['lamp']['web_app']['deploy_user']
  type node['lamp']['web_app']['deploy_key_type']
  key node['lamp']['web_app']['deploy_key']
  comment node['lamp']['web_app']['deploy_key_comment']
end

[node['lamp']['web_app']['src_root'], node['lamp']['web_app']['docroot']].each do |web_dir|
  directory web_dir do
    owner node['lamp']['web_app']['deploy_user']
    group node['lamp']['web_app']['deploy_group']
    mode '0755'
    recursive true
    action :create
  end
end

node['lamp']['web_app']['writable_dirs'].each do |writable_dir|
   directory File.join(node['lamp']['web_app']['src_root'], writable_dir) do
    owner node['apache']['user']
    group node['apache']['group']
    mode '0755'
    recursive true
    action :create
   end
end

node['lamp']['web_app']['writable_files'].each do |writable_file|
  file File.join(node['lamp']['web_app']['src_root'], writable_file) do
    owner node['apache']['user']
    group node['apache']['group']
    mode '0644'
    action :create_if_missing
  end
end

cookbook_file "#{node['lamp']['web_app']['docroot']}/#{node['lamp']['web_app']['directory_index']}" do
  owner node['lamp']['web_app']['deploy_user']
  group node['lamp']['web_app']['deploy_group']
  mode '0644'
  action :create_if_missing
end

web_app node['lamp']['web_app']['name'] do
  template 'web_app.conf.erb'
  server_name node['lamp']['web_app']['server_name']
  docroot node['lamp']['web_app']['docroot']
  directory_index node['lamp']['web_app']['directory_index']
  allow_override(node['lamp']['web_app']['allow_override'] ? 'All' : 'None')
  cookbook 'apache2'
end