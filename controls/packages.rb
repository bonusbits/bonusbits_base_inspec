require_relative '../helpers/node_attributes'
require_relative '../helpers/os_queries'

test_packages = attribute('test_packages', value: true, description: 'Test Packages').to_s.eql?('true') ? true : false

debug = attribute('debug', value: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
puts "ATTR: Test Packages             (#{test_packages})" if debug

control 'packages' do
  impact 1.0
  title ''
  only_if { test_packages }

  node = node_values
  if amazon_linux?
    packages_list = node['packages']['amazon']['packages']
  elsif redhat?
    packages_list = node['packages']['redhat']['packages']
  elsif ubuntu?
    packages_list = node['packages']['ubuntu']['packages']
  end

  packages_list.each do |package|
    describe package(package) do
      it { should be_installed }
    end
  end
end
