require_relative '../helpers/node_attributes'
require_relative '../helpers/os_queries'

# Attributes
debug = attribute('debug', value: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
test_proxy = attribute('test_proxy', value: true, description: 'Test Proxy').to_s.eql?('false') ? true : false

# Debug Outputs
puts "ATTR: Test Proxy                (#{test_proxy})" if debug

control 'proxy' do
  impact 1.0
  title ''
  only_if { test_proxy }

  # /etc/profile.d/proxy.sh
  describe file('/etc/profile.d/proxy.sh') do
    it { should exist }
    it { should be_owned_by 'root' }
  end
  proxy_shell_script_content.each do |proxy_setting|
    describe file('/etc/profile.d/proxy.sh') do
      its('content') { should include proxy_setting }
    end
  end

  # /etc/environment
  if debian_family?
    describe file('/etc/environment') do
      it { should exist }
      it { should be_owned_by 'root' }
    end

    proxy_shell_script_content.each do |proxy_setting|
      describe file('/etc/environment') do
        its('content') { should include proxy_setting }
      end
    end

    # /etc/apt/apt.conf
    node = node_values
    describe file('/etc/apt/apt.conf') do
      it { should exist }
      it { should be_owned_by 'root' }
      its('content') { should include "Acquire::http::proxy \"#{node['proxy']['host_port_url']}\";" }
      its('content') { should include "Acquire::https::proxy \"#{node['proxy']['host_port_url']}\";" }
    end
  end

  # Check Environment Variables
  proxy_settings.each do |key, value|
    describe os_env(key) do
      its('content') { should eq value }
    end
  end

  # Test proxy/no_proxy
  ## Workaround until we upgrade Inspec
  describe command('curl -I http://169.254.169.254/latest/meta-data/') do
    its('stdout') { should include '200 OK' }
  end
end
