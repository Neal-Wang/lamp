#
# Cookbook:: lamp
# Recipe:: default
#
# Copyright:: 2018, IBPort, All Rights Reserved.

include_recipe 'lamp::php'
include_recipe 'lamp::database'
include_recipe 'lamp::apache'