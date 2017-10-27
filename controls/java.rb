require_relative '../helpers/os_queries'

install_java = attribute('install_java', default: true, description: 'Install Java').to_s.eql?('true') ? true : false
java_package_name = attribute('java_package_name', default: 'java-1.8.0-openjdk', description: 'Java Version')
specify_version = attribute('specify_version', default: true, description: 'Specify Version').to_s.eql?('true') ? true : false
java_version = attribute('java_version', default: '1.8.0.141-1.b16.el7_3', description: 'Java Version')

debug = attribute('debug', default: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
if debug
  puts "ATTR: Install Java           (#{install_java})"
  puts "ATTR: Java Package           (#{java_package_name})"
  puts "ATTR: Specify Version        (#{specify_version})"
  puts "ATTR: Java Version           (#{java_version})"
end

# Check if Installed
if install_java
  if os.linux?
    # describe package(java_package_name) do
    #   it { should be_installed }
    #   its('version') { should eq java_version }
    # end
    describe 'Java Install' do
      it 'Installed' do
        expect(package(java_package_name)).to be_installed
      end
      if specify_version
        it "Version: (#{java_version})" do
          expect(package(java_package_name).version).to match(java_version)
        end
      end
    end
  end
end
