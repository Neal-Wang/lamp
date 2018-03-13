# # encoding: utf-8

# Inspec test for recipe lamp::database

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

socket = '/run/mysql-default/mysqld.sock'

describe port(3306) do
  it { should be_listening }
end

describe service('mysql-default') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe directory('/var/run/mysqld') do
  it { should exist }
  its('owner') { should eq 'mysql' }
  its('group') { should eq 'mysql' }
  its('mode') { should eq 493 }
end

describe file('/var/run/mysqld/mysqld.sock') do
  it { should exist }
  it { should be_symlink }
  it { should be_linked_to socket }
end

describe command('mysql -uroot -pibportrnd153 -e "show databases;"') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /slimsampledb/ }
end

describe command('mysql -uslimsampleuser -pslimsamplepw -e "show databases;"') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /slimsampledb/ }
end
