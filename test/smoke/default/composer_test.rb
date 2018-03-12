# # encoding: utf-8

# Inspec test for recipe lamp::composer

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe command('composer -V') do
  its('exit_status') { should eq 0 }
end
