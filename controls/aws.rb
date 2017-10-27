require_relative '../helpers/os_queries'

inside_aws = ec2?
configure = attribute('configure_aws_profile', default: true, description: 'Configure Proxy').to_s.eql?('true') ? true : false

debug = attribute('debug', default: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
puts "ATTR: Configure AWS Profile  (#{configure})" if debug

profile_settings = %w(
  AWS_REGION
)

if os.linux? && inside_aws
  if configure
    describe 'AWS Profile' do
      it 'Configured' do
        profile_settings.each do |value|
          expect(file('/etc/profile.d/aws.sh').content).to match(value)
        end
      end
    end
  else
    describe 'AWS Profile' do
      it 'Not Configured' do
        expect(file('/etc/profile.d/aws.sh')).to_not exist
      end
    end
  end
end
