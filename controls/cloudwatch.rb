require_relative '../helpers/os_queries'

inside_aws = ec2?
configure = attribute('configure_cloudwatch', default: true, description: 'Configure CloudWatch Monitoring').to_s.eql?('true') ? true : false

debug = attribute('debug', default: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
if debug
  puts "ATTR: Inside AWS              (#{inside_aws})"
  puts "ATTR: Configure CloudWatch    (#{configure})"
end

if os.linux? && configure
  describe 'CloudWatch Monitoring' do
    it 'Scripts' do
      expect(file('/opt/aws-scripts-mon/mon-put-instance-data.pl')).to exist
      expect(file('/opt/aws-scripts-mon/mon-put-instance-data.pl')).to be_owned_by('root')
    end

    if inside_aws
      it 'Cron' do
        expect(service('awslogs')).to be_enabled
        expect(service('awslogs')).to be_running
      end
    end
  end
end
