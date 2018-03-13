# # encoding: utf-8

# Inspec test for recipe lamp::web_app

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

base_dir = '/var/www/slimsample'

describe user('deploy') do
  it { should exist }
  its('home') { should eq '/home/deploy' }
  its('group') { should eq 'deploy' }
  its('shell') { should eq '/bin/bash' }
end

describe group('deploy') do
  it { should exist }
end

describe file('/home/deploy/.ssh/authorized_keys') do
  it { should exist }
  its('owner') { should eq 'deploy' }
  its('mode') { should eq 384 }
  its('content') { should eq "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfXeuJ8T6ASzJUC0x1VQctUH3Y66RW9iOtUo8pHNJ6hP2PmcKWzaNPkGFFzcwzny/c1lz/GJ44/ebJbBEu8r2RlwumAUBwKYzyrrbU0HeWvZflNd9ZjETYkfEl7YhuiD79WsnSxWjGzgRnBTYGe2GeinsuK3mTvoDfDt2gWCZpYai5rrPUOw+OFkeAvZSMKVTIiFY9wCkjgRfIU2swbXl1OPKIcV+/TDE0p2On9oH+cDFudscGsGBdIwExyvcxyYnWtBpFfeoMti+nIJH1JgKeoEdxnyslh5FOzlQkm+oM+KYf/f3Rg+bR40oduPrItWXwjV/aT+keOuvhr7t7f4af Admin@OPTI990-068\n" }
end

['/var/www/slimsample', '/var/www/slimsample/public'].each do |web_dir|
  describe directory(web_dir) do
    it { should exist }
    its('owner') { should eq 'deploy' }
    its('group') { should eq 'deploy' }
    its('mode') { should eq 493 }
  end
end

['cache', 'tmp', 'logs'].each do |writable_dir|
  describe directory(File.join(base_dir, writable_dir)) do
    it { should exist }
    its('owner') { should eq 'www-data' }
    its('group') { should eq 'www-data' }
    its('mode') { should eq 493 }
  end
end

['logs/app.log'].each do |writable_file|
  describe file(File.join(base_dir, writable_file)) do
    it { should exist }
    its('owner') { should eq 'www-data' }
    its('group') { should eq 'www-data' }
    its('mode') { should eq 420 }
  end
end

describe file(File.join(base_dir, 'public', 'index.php')) do
  it { should exist }
  its('owner') { should eq 'deploy' }
  its('group') { should eq 'deploy' }
  its('mode') { should eq 420 }
end

describe command('apache2ctl -S') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /slimsample/ }
end
