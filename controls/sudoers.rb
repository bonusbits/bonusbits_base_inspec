require_relative '../helpers/os_queries'

configure_sudoers = attribute('configure_sudoers', default: false, description: 'Configure Sudoers').to_s.eql?('true') ? true : false

debug = attribute('debug', default: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
puts "ATTR: Configure Sudoers      (#{configure_sudoers})" if debug

if configure_sudoers && rhel_family?
  describe 'Sudoers Config' do
    it 'has /usr/local/bin in sudoers secure path' do
      expect(file('/etc/sudoers').content).to match(%r{secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin$})
    end
  end
end
