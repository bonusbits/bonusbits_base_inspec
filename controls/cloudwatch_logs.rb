require_relative '../helpers/os_queries'

# Can not call method in Describe call, but can use local variable as condition.
inside_aws = aws?
test_cloudwatch_logs = input('test_cloudwatch_logs', value: inside_aws, description: 'Test CloudWatch Logs')

debug = input('debug', value: false, description: 'Enable Debugging')
puts "DEBUG: Test CloudWatch Logs      (#{test_cloudwatch_logs})" if debug

control 'cloudwatch_logs' do
  impact 1.0
  title ''
  only_if { os.linux? && test_cloudwatch_logs && inside_aws }

  if amazon_linux?
    describe package('awslogs') do
      it { should be_installed }
    end

    describe service('awslogs') do
      it { should be_enabled }
      it { should be_running }
    end
    describe service('awslogs') do
      it { should be_installed }
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
