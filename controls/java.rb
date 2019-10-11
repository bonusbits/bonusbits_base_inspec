require_relative '../helpers/os_queries'

test_java = attribute('test_java', value: false, description: 'Test Java').to_s.eql?('true') ? true : false
java_package_name = attribute('java_package_name', value: 'java-1.8.0-openjdk', description: 'Java Version')
java_specify_version = attribute('java_specify_version', value: false, description: 'Specify Version').to_s.eql?('true') ? true : false
java_version = attribute('java_version', value: '1.8.0.151-1.b12.35.amzn1', description: 'Java Version')

debug = attribute('debug', value: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
if debug
  puts "ATTR: Test Java                 (#{test_java})"
  puts "ATTR: Java Package              (#{java_package_name})"
  puts "ATTR: Specify Version           (#{java_specify_version})"
  puts "ATTR: Java Version              (#{java_version})"
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
