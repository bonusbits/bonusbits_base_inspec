require_relative '../helpers/os_queries'

# Can not call method in Describe call, but can use local variable as condition.
inside_aws = ec2?
test_cloudwatch_logs = attribute('test_cloudwatch_logs', value: true, description: 'Test CloudWatch Logs').to_s.eql?('true') ? true : false

debug = attribute('debug', value: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
puts "ATTR: Test CloudWatch Logs      (#{test_cloudwatch_logs})" if debug

control 'cloudwatchlogs' do
  impact 1.0
  title ''
  only_if { os.linux? && test_cloudwatch_logs }

  if amazon_linux?
    if inside_aws
      describe package('awslogs') do
        it { should be_installed }
      end

      describe service('awslogs') do
        it { should be_enabled }
        it { should be_running }
      end
    else
      describe service('awslogs') do
        it { should be_installed }
      end
    end
  end

  config_file = amazon_linux? ? '/etc/awslogs/awscli.conf' : '/etc/awslogs/aws.conf'
  describe file(config_file) do
    it { should exist }
    it { should be_owned_by 'root' }
  end

  describe file('/etc/awslogs/awslogs.conf') do
    it { should exist }
    it { should be_owned_by 'root' }
  end

  describe file('/etc/awslogs/proxy.conf') do
    it { should exist }
    it { should be_owned_by 'root' }
  end
end
