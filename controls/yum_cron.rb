require_relative '../helpers/os_queries'
configure_yum_cron = attribute('configure_yum_cron', default: true, description: 'Configure Yum Cron')

if configure_yum_cron && amazon?
  describe 'Yum Cron' do
    it 'yum-cron installed' do
      expect(package('yum-cron')).to be_installed
    end

    it 'has yum-cron.conf' do
      expect(file('/etc/yum/yum-cron.conf')).to exist
      expect(file('/etc/yum/yum-cron.conf')).to be_owned_by('root')
    end

    it 'has yum-cron-hourly.conf' do
      expect(file('/etc/yum/yum-cron-hourly.conf')).to exist
      expect(file('/etc/yum/yum-cron-hourly.conf')).to be_owned_by('root')
    end

    it 'yum-cron service' do
      expect(service('yum-cron')).to be_enabled
      expect(service('yum-cron')).to be_running
    end

    it 'yum-cron.conf used correct template' do
      expect(file('/etc/yum/yum-cron.conf').content).to match(/^download_updates = yes/)
    end

    it 'yum-cron-hourly.conf used correct template' do
      expect(file('/etc/yum/yum-cron-hourly.conf').content).to match(/^download_updates = no/)
    end
  end
end
