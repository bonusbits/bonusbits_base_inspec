require_relative '../helpers/os_queries'

# TODO: Add Logic to test packages aren't installed when install attribute set to false. Such as, awscli, cd git, vim, etc.

# Fetch Chef Node Attributes
node = node_attributes
install_packages = node['bonusbits_base']['packages']['install']

test_packages = input('test_packages', value: install_packages, description: 'Test Packages')

debug = input('debug', value: false, description: 'Enable Debugging')
puts "DEBUG: Test Packages             (#{test_packages})" if debug

control 'packages' do
  impact 1.0
  title ''
  only_if { test_packages }

  if amazon_linux?
    if amazon_linux1?
      packages_list = node['bonusbits_base']['packages']['amazon_linux1']['packages']
    elsif amazon_linux2?
      packages_list = node['bonusbits_base']['packages']['amazon_linux2']['packages']
    end
  elsif redhat?
    packages_list = node['bonusbits_base']['packages']['redhat']['packages']
  elsif ubuntu?
    packages_list = node['bonusbits_base']['packages']['ubuntu']['packages']
  end

  packages_list.each do |package|
    describe package(package) do
      it { should be_installed }
    end
  end
end
