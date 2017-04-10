configure_proxy = attribute('configure_proxy', default: false, description: 'Configure Proxy').to_s.eql?('true') ? true : false

debug = attribute('debug', default: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
puts "ATTR: Configure Proxy        (#{configure_proxy})" if debug

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

if os.linux?
  if configure_proxy
    describe 'Network Proxy' do
      it 'Configured' do
        proxy_settings.each do |proxy_setting|
          expect(file('/etc/profile.d/proxy.sh').content).to match(proxy_setting)
        end
      end
    end
  else
    describe 'Network Proxy' do
      it 'Not Configured' do
        expect(file('/etc/profile.d/proxy.sh')).to_not exist
      end
    end
  end
end
