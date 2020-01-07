require_relative '../helpers/os_queries'

# Fetch Chef Node Attributes
node = node_attributes
configure = node['bonusbits_base']['sudoers']['configure']

test_sudoers = input('test_sudoers', value: configure, description: 'Test Sudoers')

debug = input('debug', value: false, description: 'Enable Debugging')
puts "DEBUG: Test Sudoers              (#{test_sudoers})" if debug

control 'sudoers' do
  impact 1.0
  title ''
  only_if { test_sudoers }

  # has /usr/local/bin in sudoers secure path
  describe file('/etc/sudoers') do
    its('content') { should include 'secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin' }
  end
end
