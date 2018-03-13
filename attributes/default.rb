default['lamp']['database']['instance_name'] = 'default'
default['lamp']['database']['port'] = 3306
default['lamp']['database']['version'] = '5.7'
default['lamp']['database']['root_password'] = 'ibportrnd153'
default['lamp']['database']['host'] = 'localhost'
default['lamp']['database']['name'] = 'slimsampledb'
default['lamp']['database']['user'] = 'slimsampleuser'
default['lamp']['database']['password'] = 'slimsamplepw'
default['lamp']['database']['deploy_user'] = 'mysql'
default['lamp']['database']['deploy_group'] = 'mysql'

default['lamp']['web_app']['name'] = 'slimsample'
default['lamp']['web_app']['server_name'] = '127.0.0.1'
default['lamp']['web_app']['docroot'] = '/var/www/slimsample/public'
default['lamp']['web_app']['directory_index'] = 'index.php'
default['lamp']['web_app']['allow_override'] = true
default['lamp']['web_app']['src_root'] = '/var/www/slimsample'
default['lamp']['web_app']['writable_dirs'] = []
default['lamp']['web_app']['writable_files'] = []
default['lamp']['web_app']['deploy_user'] = 'deploy'
default['lamp']['web_app']['deploy_group'] = 'deploy'
default['lamp']['web_app']['deploy_key_type'] = 'ssh-rsa'
default['lamp']['web_app']['deploy_key'] = ''
default['lamp']['web_app']['deploy_key_comment'] = ''

default['apache']['contact'] = 'wangql.dev@gmail.com'
default['apache']['log_level'] = 'info'
default['apache']['mpm'] = 'prefork'
