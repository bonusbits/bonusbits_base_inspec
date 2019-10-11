require_relative '../helpers/os_queries'

test_cloudwatch = attribute('test_cloudwatch', value: true, description: 'Test CloudWatch').to_s.eql?('true') ? true : false

debug = attribute('debug', value: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
puts "ATTR: Test CloudWatch           (#{test_cloudwatch})" if debug

control 'cloudwatch' do
  impact 1.0
  title ''
  only_if { os.linux? && test_cloudwatch }

  describe file('/opt/aws-scripts-mon/mon-put-instance-data.pl') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its(:mode) { should cmp '00755' }
  end
end
