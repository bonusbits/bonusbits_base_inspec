require_relative '../helpers/os_queries'

chef_installed = File.directory?('/opt/chef') || File.directory?('/opt/chefdk')

test_chef = input('test_chef', value: chef_installed, description: 'Test Chef')
chef_client_version = input('chef_client_version', value: '15.4.45', description: 'Chef Client Version')
chef_dk_version = input('chef_dk_version', value: '4.5.0', description: 'ChefDK Version')

debug = input('debug', value: false, description: 'Enable Debugging')
if debug
  puts "DEBUG: Test Chef                 (#{test_chef})"
  puts "DEBUG: Chef Client Version       (#{chef_client_version})"
  puts "DEBUG: Chef DK Version           (#{chef_dk_version})"
end

control 'chef_client' do
  impact 1.0
  title ''
  only_if { test_chef }

  knife_path =
    if File.exist?('/opt/chefdk/embedded/bin/knife')
      '/opt/chefdk/embedded/bin/knife'
    else
      '/opt/chef/embedded/bin/knife'
    end

  describe command("#{knife_path} -v") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should include(chef_client_version) }
  end
end

control 'chef_dk' do
  impact 1.0
  title ''
  only_if { test_chef && File.directory?('/opt/chefdk') }

  describe command('/opt/chefdk/embedded/bin/chef -v') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should include("ChefDK version: #{chef_dk_version}") }
  end
end
