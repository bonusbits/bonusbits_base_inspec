configure_proxy = attribute('install_software', default: true, description: 'Install Software Packages')

proxy_settings = %w(
  ftp_proxy=http://10.0.2.2:8888
  http_proxy=http://10.0.2.2:8888
  https_proxy=http://10.0.2.2:8888
  no_proxy=localhost,127.0.0.1,10.0.2.,33.33.33.,.localdomain.com
  FTP_PROXY=http://10.0.2.2:8888
  HTTPS_PROXY=http://10.0.2.2:8888
  HTTP_PROXY=http://10.0.2.2:8888
  NO_PROXY=localhost,127.0.0.1,10.0.2.,33.33.33.,.localdomain.com
)

if linux?
  if configure_proxy
    describe 'Proxy' do
      it 'Configured' do
        proxy_settings.each do |proxy_setting|
          expect(file('/etc/environment').content).to match(proxy_setting)
        end
      end
    end
  else
    describe 'Proxy' do
      it 'Not Configured' do
        proxy_settings.each do |proxy_setting|
          expect(file('/etc/environment').content).to_not match(proxy_setting)
        end
      end
    end
  end
end
