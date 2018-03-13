# # encoding: utf-8

# Inspec test for recipe lamp::web_app

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe command('apache2ctl -S') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /slimsample/ }
end
