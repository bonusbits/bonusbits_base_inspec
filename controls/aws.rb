require_relative '../helpers/os_queries'

inside_aws = ec2?
test_aws = input('test_aws', value: inside_aws, description: 'Test AWS')

debug = input('debug', value: false, description: 'Enable Debugging')
if debug
  puts "DEBUG: Inside AWS                (#{inside_aws})"
  puts "DEBUG: Test AWS                  (#{test_aws})"
end

control 'aws' do
  impact 1.0
  title ''
  only_if { test_aws && inside_aws }

  describe file('/etc/profile.d/aws.sh') do
    it { should exist }
    it { should be_owned_by 'root' }
    its('content') { should include match(/AWS_REGION/) }
  end
end
