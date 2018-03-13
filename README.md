# lamp Chef Cookbook

This chef cookbook is used to deploy lamp.

## Requirements

### Chef

Tested on 13.6.4, but version newer than 12.1 should work just fine. File an [issue](https://bitbucket.org/wangql-dev/lamp/issues) if this isn't the case.

### Platform

The following platforms have been tested with this cookbook:

* ubuntu (16.04) 

## Recipes

### default

Install apache2 + mysql (server, client) + php (include composer).

Mysql root password will be set to node['lamp']['database']['root_password']. 

A database named node['lamp']['database']['name'] will be created and a database user 
node['lamp']['database']['user'] will be created and identified by node['lamp']['database']['password'].
All privileges of the created database will be granted to the created user.

By default, these php modules are installed:

php-curl, php-date, php-gd, php-json, php-mbstring, php-mysql, php-xml, php-fpm, php-soap, php-pear, php-mcrypt

### web_app

Add an apache2 VHost configuration for a site and add a deploy user and related authorized key to enable deploy via ssh.

## Attributes

Refer to [attributes/default.rb](https://bitbucket.org/wangql-dev/lamp/src/master/attributes/default.rb).