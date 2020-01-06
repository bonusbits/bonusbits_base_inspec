require_relative '../helpers/os_queries'

# Attributes
debug = input('debug', value: false, description: 'Enable Debugging')
test_nodeinfo = input('test_nodeinfo', value: true, description: 'Test NodeInfo')

# Debug Outputs
puts "DEBUG: Test NodeInfo             (#{test_nodeinfo})" if debug

control 'nodeinfo' do
  impact 1.0
  title ''
  only_if { test_nodeinfo }

  describe file('/etc/chef/.chef-attributes.json') do
    it { should exist }
  end
  describe file('/usr/local/bin/nodeinfo') do
    it { should exist }
  end
end
