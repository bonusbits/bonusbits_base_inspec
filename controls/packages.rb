require_relative '../helpers/os_queries'

install_software = attribute('install_software', default: true, description: 'Install Software Packages')

rh_package_list = %w(vim-enhanced mlocate wget)
deb_package_list = %w(vim mlocate wget)

# Check if Installed
if rhel_family?
  if install_software
    describe 'RHEL Packages' do
      it 'Installed' do
        rh_package_list.each do |package|
          expect(package(package)).to be_installed
        end
      end
    end
  else
    # Split out because wget is often installed by default.
    describe 'RHEL Packages' do
      it 'Not Installed' do
        expect(package('vim-enhanced')).to_not be_installed
        expect(package('mlocate')).to_not be_installed
      end
    end
  end
elsif debian_family?
  if install_software
    describe 'Debian Packages' do
      it 'Installed' do
        deb_package_list.each do |package|
          expect(package(package)).to be_installed
        end
      end
    end
  else
    describe 'Debian Packages' do
      it 'Not Installed' do
        expect(package('htop')).to_not be_installed
        expect(package('vim')).to_not be_installed
        expect(package('mlocate')).to_not be_installed
      end
    end
  end
end
