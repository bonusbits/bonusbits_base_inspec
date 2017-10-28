require_relative '../helpers/os_queries'

configure = attribute('configure_yum_cron', default: true, description: 'Configure Yum Cron').to_s.eql?('true') ? true : false

debug = attribute('debug', default: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
puts "ATTR: Configure Yum Cron     (#{configure})" if debug

if configure && amazon?
  describe 'Yum Cron' do
    it 'yum-cron installed' do
      expect(package('yum-cron')).to be_installed
    end

    it 'yum-cron.conf' do
      expect(file('/etc/yum/yum-cron.conf')).to exist
      expect(file('/etc/yum/yum-cron.conf')).to be_owned_by('root')
    end

    it 'yum-cron-hourly.conf' do
      expect(file('/etc/yum/yum-cron-hourly.conf')).to exist
      expect(file('/etc/yum/yum-cron-hourly.conf')).to be_owned_by('root')
    end

    it 'Service' do
      expect(service('yum-cron')).to be_enabled
      expect(service('yum-cron')).to be_running
    end

    it 'yum-cron.conf template used' do
      expect(file('/etc/yum/yum-cron.conf').content).to match(/^download_updates = yes/)
    end

    it 'yum-cron-hourly.conf template used' do
      expect(file('/etc/yum/yum-cron-hourly.conf').content).to match(/^download_updates = no/)
    end
  end
end
