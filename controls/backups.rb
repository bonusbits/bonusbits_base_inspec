require_relative '../helpers/os_queries'

# Fetch Chef Node Attributes
node = node_attributes
configure = node['bonusbits_base']['backups']['configure']

test_backups = input('test_backups', value: configure, description: 'Test Backups')

debug = input('debug', value: false, description: 'Enable Debugging')
puts "DEBUG: Test Backups              (#{test_backups})" if debug

control 'backups' do
  impact 1.0
  title ''
  only_if { test_backups }

  # Fetch Chef Node Attributes
  node = node_attributes
  configure = node['bonusbits_base']['backups']['configure']
  only_if { os.linux? && test_backups && configure }

  describe file('/usr/bin/backup_to_s3.rb') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its(:mode) { should cmp '00755' }
  end
end
