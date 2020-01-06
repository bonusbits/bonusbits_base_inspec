require_relative '../helpers/os_queries'

# Fetch Chef Node Attributes
node = node_attributes
install_java = node['bonusbits_base']['java']['install']
java_package = node['bonusbits_base']['java']['package']
java_ver = node['bonusbits_base']['java']['version']
specify_version = node['bonusbits_base']['java']['specify_version']

# Still allowing overriding inputs, but should be auto-populated with Node Attributes
test_java = input('test_java', value: install_java, description: 'Test Java')
java_package_name = input('java_package_name', value: java_package, description: 'Java Package Name')
java_specify_version = input('java_specify_version', value: specify_version, description: 'Specify Version')
java_version = input('java_version', value: java_ver, description: 'Java Version')

debug = input('debug', value: false, description: 'Enable Debugging')
if debug
  puts "DEBUG: Test Java                 (#{test_java})"
  puts "DEBUG: Java Package              (#{java_package_name})"
  puts "DEBUG: Specify Version           (#{java_specify_version})"
  puts "DEBUG: Java Version              (#{java_version})"
end

control 'java' do
  impact 1.0
  title ''
  only_if { os.linux? && test_java }

  describe package(java_package_name) do
    it { should be_installed }
  end

  if java_specify_version
    describe package(java_package_name) do
      it { should be_installed }
      its('version') { should include match(java_version) }
    end
  end
end
