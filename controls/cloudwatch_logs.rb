require_relative '../helpers/os_queries'

# Can not call method in Describe call, but can use local variable as condition.
inside_aws = ec2?
amazon = amazon?
configure = attribute('configure_cloudwatch_logs', default: true, description: 'Configure CloudWatch Logs').to_s.eql?('true') ? true : false

debug = attribute('debug', default: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
if debug
  puts "ATTR: Inside AWS                (#{inside_aws})"
  puts "ATTR: Configure CloudWatch Logs (#{configure})"
end

if os.linux? && configure
  describe 'CloudWatch Logs' do
    if amazon
      it 'Agent RPM' do
        expect(package('awslogs')).to be_installed
      end
    end

    it 'awscli.conf' do
      expect(file('/etc/awslogs/awscli.conf')).to exist
      expect(file('/etc/awslogs/awscli.conf')).to be_owned_by('root')
    end

    if inside_aws
      it 'awslogs.conf' do
        expect(file('/etc/awslogs/awslogs.conf')).to exist
        expect(file('/etc/awslogs/awslogs.conf')).to be_owned_by('root')
      end

      it 'Service' do
        expect(service('awslogs')).to be_enabled
        expect(service('awslogs')).to be_running
      end
    end
  end
end
