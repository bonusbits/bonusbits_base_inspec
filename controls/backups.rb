require_relative '../helpers/os_queries'

inside_aws = ec2?
configure = attribute('configure_backups', default: false, description: 'Configure Backups').to_s.eql?('true') ? true : false

debug = attribute('debug', default: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
if debug
  puts "ATTR: Inside AWS              (#{inside_aws})"
  puts "ATTR: Configure Backups       (#{configure})"
end

if os.linux? && configure
  describe 'Backup Script' do
    it '/usr/bin/backup_to_s3.rb' do
      expect(file('/usr/bin/backup_to_s3.rb')).to exist
      expect(file('/usr/bin/backup_to_s3.rb')).to be_owned_by('root')
    end
  end
end
