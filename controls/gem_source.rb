require_relative '../helpers/os_queries'

# Fetch Chef Node Attributes
node = node_attributes
configure = node['bonusbits_base']['gem_source']['configure']
chef_path = node['bonusbits_base']['chef_path']
source_url = node['bonusbits_base']['gem_source']['source_url']

test_gem_source = input('test_gem_source', value: configure, description: 'Test Gem Source')

debug = input('debug', value: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
puts "DEBUG: Test Gem Source           (#{test_gem_source})" if debug

control 'gem_source' do
  impact 1.0
  title ''
  only_if { os.linux? && test_gem_source }

  describe command("#{chef_path}/embedded/bin/gem sources") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should include match(source_url) }
  end
end
