require_relative '../helpers/node_attributes'
require_relative '../helpers/os_queries'

# Attributes
debug = attribute('debug', value: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
test_nodeinfo = attribute('test_nodeinfo', value: true, description: 'Test NodeInfo').to_s.eql?('true') ? true : false

# Debug Outputs
puts "ATTR: Test NodeInfo             (#{test_nodeinfo})" if debug

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
