require_relative '../helpers/os_queries'

install_packages = attribute('install_packages', default: true, description: 'Install Software Packages')

amazon_packages = attribute(
  'amazon_packages',
  default: %w(
    aws-cli
    ca-certificates
    curl
    git
    gzip
    htop
    mlocate
    net-tools
    openssh-clients
    openssh-server
    openssl
    procps
    sudo
    upstart
    util-linux
    vim-enhanced
    which
  ),
  description: 'Amazon Linux Software Packages'
)

redhat_packages = attribute(
  'redhat_packages',
  default: %w(
    ca-certificates
    curl
    git
    gzip
    mlocate
    net-tools
    openssh-clients
    openssh-server
    openssl
    procps
    sudo
    upstart
    util-linux-ng
    vim-enhanced
    which
  ),
  description: 'Redhat Linux Software Packages'
)

debian_packages = attribute(
  'debian_packages',
  default: %w(
    curl
    git
    gzip
    htop
    mlocate
    net-tools
    openssl
    procps
    sudo
    util-linux
    vim
    which
  ),
  description: 'Debian Linux Software Packages'
)

suse_packages = attribute(
  'suse_packages',
  default: %w(
    curl
    git
    gzip
    htop
    mlocate
    net-tools
    openssl
    procps
    sudo
    util-linux
    vim
    which
  ),
  description: 'Suse Linux Software Packages'
)

windows_packages = attribute(
  'windows_packages',
  default: %w(
    powershell
    sysinternals
    git
  ),
  description: 'Suse Linux Software Packages'
)

# Check if Installed
if install_packages
  if os.redhat?
    describe 'RHEL Packages' do
      it 'Installed' do
        redhat_packages.each do |package|
          expect(package(package)).to be_installed
        end
      end
    end
  elsif amazon?
    describe 'Amazon Packages' do
      it 'Installed' do
        amazon_packages.each do |package|
          expect(package(package)).to be_installed
        end
      end
    end
  elsif debian_family?
    describe 'Debian Packages' do
      it 'Installed' do
        debian_packages.each do |package|
          expect(package(package)).to be_installed
        end
      end
    end
  elsif os.suse?
    describe 'Suse Packages' do
      it 'Installed' do
        suse_packages.each do |package|
          expect(package(package)).to be_installed
        end
      end
    end
  elsif os.windows?
    describe 'Windows Packages' do
      it 'Installed' do
        windows_packages.each do |package|
          expect(package(package)).to be_installed
        end
      end
    end
  end
end
