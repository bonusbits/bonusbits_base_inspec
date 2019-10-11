require_relative '../helpers/os_queries'

test_sudoers = attribute('test_sudoers', value: false, description: 'Test Sudoers').to_s.eql?('true') ? true : false

debug = attribute('debug', value: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
puts "ATTR: Test Sudoers              (#{test_sudoers})" if debug


control 'sudoers' do
  impact 1.0
  title ''
  only_if { test_sudoers }

  # has /usr/local/bin in sudoers secure path
  describe file('/etc/sudoers') do
    its('content') { should include 'secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin$' }
  end
end
