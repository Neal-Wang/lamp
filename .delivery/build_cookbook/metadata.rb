name 'build_cookbook'
maintainer 'IBPort'
maintainer_email 'wangql.dev@gmail.com'
license 'all_rights'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'delivery-truck'
