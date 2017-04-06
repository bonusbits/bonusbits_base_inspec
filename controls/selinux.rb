require_relative '../helpers/os_queries'

configure_selinux = attribute('configure_selinux', default: true, description: 'Configure Selinux').to_s.eql?('true') ? true : false

debug = attribute('debug', default: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
puts "ATTR: Configure SeLinux      (#{configure_selinux})" if debug

unless docker?
  if os.redhat? && configure_selinux
    describe 'SELinux' do
      it 'Disabled' do
        expect(file('/etc/selinux/config').content).to match(/SELINUX=disabled/)
      end
    end
  end
end
