require_relative '../helpers/os_queries'

test_selinux = attribute('test_selinux', value: true, description: 'Configure Selinux').to_s.eql?('true') ? true : false

debug = attribute('debug', value: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
puts "ATTR: Test SeLinux              (#{test_selinux})" if debug

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
