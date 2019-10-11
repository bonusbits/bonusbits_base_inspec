require_relative '../helpers/os_queries'

inside_aws = ec2?
test_aws = attribute('test_aws', value: true, description: 'Test AWS').to_s.eql?('true') ? true : false

debug = attribute('debug', value: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
if debug
  puts "ATTR: Inside AWS                (#{inside_aws})"
  puts "ATTR: Test AWS                  (#{test_aws})"
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
