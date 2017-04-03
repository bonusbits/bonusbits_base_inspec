require_relative '../helpers/os_queries'

unless docker?
  if os.redhat?
    describe 'SELinux' do
      it 'Disabled' do
        expect(file('/etc/selinux/config').content).to match(/SELINUX=disabled/)
      end
    end
  end
end