require_relative '../helpers/os_queries'

# Fetch Chef Node Attributes
node = node_attributes
configure = node['bonusbits_base']['security']['selinux']['configure']

test_selinux = input('test_selinux', value: configure, description: 'Configure Selinux')

debug = input('debug', value: false, description: 'Enable Debugging')
puts "DEBUG: Test SeLinux              (#{test_selinux})" if debug

control 'selinux' do
  impact 1.0
  title ''
  only_if { redhat? && test_selinux }

  unless docker?
    describe file('/etc/selinux/config') do
      its('content') { should include 'SELINUX=disabled' }
    end
  end
end
