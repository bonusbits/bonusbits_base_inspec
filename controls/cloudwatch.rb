require_relative '../helpers/os_queries'

# Can not call method in Describe call, but can use local variable as condition.
inside_aws = aws?
test_cloudwatch = input('test_cloudwatch', value: inside_aws, description: 'Test CloudWatch')

debug = input('debug', value: false, description: 'Enable Debugging')
puts "DEBUG: Test CloudWatch           (#{test_cloudwatch})" if debug

control 'cloudwatch' do
  impact 1.0
  title ''
  only_if { os.linux? && test_cloudwatch && inside_aws }

  describe file('/opt/aws-scripts-mon/mon-put-instance-data.pl') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its(:mode) { should cmp '00755' }
  end
end
