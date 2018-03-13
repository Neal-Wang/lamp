# # encoding: utf-8

# Inspec test for recipe lamp::php

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe command('php -v') do
  its('exit_status') { should eq 0 }
end

%w(curl date gd json mbstring mysql xml fpm soap pear mcrypt mysql).each do |mod|
  describe package("php-#{mod}") do
  	it { should be_installed }
  end
end

describe command('php -m') do
  its('exit_status') { should eq 0 }
  %w(curl date gd json mbstring mysql xml mcrypt mysql).each do |mod|
  	its('stdout') { should match Regexp.new(mod, Regexp::IGNORECASE) }
  end
end
