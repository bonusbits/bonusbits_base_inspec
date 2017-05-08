require_relative '../helpers/os_queries'

inside_aws = ec2?
configure_cloudwatch_logs = attribute('configure_cloudwatch_logs', default: true, description: 'Configure CloudWatch Logs').to_s.eql?('true') ? true : false

debug = attribute('debug', default: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
if debug
  puts "ATTR: Inside AWS              (#{inside_aws})"
  puts "ATTR: Configure CloudWatch Logs (#{configure_cloudwatch_logs})"
end

if os.linux? && configure_cloudwatch_logs
  describe 'CloudWatch Logs' do
    it 'awslogs installed' do
      expect(package('awslogs')).to be_installed
    end

    it 'has awscli.conf' do
      expect(file('/etc/awslogs/awscli.conf')).to exist
      expect(file('/etc/awslogs/awscli.conf')).to be_owned_by('root')
    end

    it 'has awslogs.conf' do
      expect(file('/etc/awslogs/awslogs.conf')).to exist
      expect(file('/etc/awslogs/awslogs.conf')).to be_owned_by('root')
    end

    if inside_aws
      it 'awslogs service' do
        expect(service('awslogs')).to be_enabled
        expect(service('awslogs')).to be_running
      end
    end
  end
end
