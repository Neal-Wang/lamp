#
# Cookbook:: lamp
# Recipe:: apache
#
# Copyright:: 2018, IBPort, All Rights Reserved.

include_recipe 'apache2'
include_recipe 'apache2::mod_php'

if node['apache']['mod_php']['module_name'] == 'php5'
  apache_config 'php-cgi'
else
  apache_config 'php7.0-cgi'
end
