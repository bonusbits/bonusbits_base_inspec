require_relative '../helpers/os_queries'

test_backups = attribute('test_backups', value: false, description: 'Test Backups').to_s.eql?('true') ? true : false

debug = attribute('debug', value: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
puts "ATTR: Test Backups              (#{test_backups})" if debug

control 'backups' do
  impact 1.0
  title ''
  only_if { os.linux? && test_backups }

  describe file('/usr/bin/backup_to_s3.rb') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its(:mode) { should cmp '00755' }
  end
end
