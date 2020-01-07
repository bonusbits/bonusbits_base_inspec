require_relative '../helpers/os_queries'

# Fetch Chef Node Attributes
node = node_attributes
configure = node['bonusbits_base']['bash_profile']['configure']

test_bash_profile = input('test_bash_profile', value: configure, description: 'Test Bash Profile')

debug = input('debug', value: false, description: 'Enable Debugging')
puts "DEBUG: Test Bash Profile         (#{test_bash_profile})" if debug

control 'bash_profile' do
  impact 1.0
  title ''
  only_if { os.linux? && test_bash_profile }

  if amazon_linux?
    describe package('update-motd') do
      it { should be_installed }
    end

    describe file('/etc/update-motd.d/30-banner') do
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      its(:mode) { should cmp '00755' }
    end

    describe file('/etc/profile.d/bonusbits_profile.sh') do
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      its(:mode) { should cmp '00644' }
    end

    describe file('/var/lib/update-motd/bonusbits_banner') do
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      its(:mode) { should cmp '00644' }
    end

    if amazon_linux1?
      describe package('lolcat') do
        it { should be_installed }
      end
    elsif amazon_linux2?
      describe file('/opt/chefdk/embedded/bin/lolcat') do
        it { should exist }
      end
    end
  end
end
