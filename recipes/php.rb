#
# Cookbook:: lamp
# Recipe:: php
#
# Copyright:: 2018, IBPort, All Rights Reserved.

apt_update 'update_apt' do
	action :update
end

include_recipe 'php'

%w(curl date gd json mbstring mysql xml fpm soap pear mcrypt mysql).each do |mod|
  package "php-#{mod}"
end