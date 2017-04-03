# require_relative '../helpers/os_queries'

if linux?
  describe 'Nodeinfo Script' do
    it 'has /usr/local/bin/nodeinfo' do
      expect(file('/usr/local/bin/nodeinfo')).to exist
    end
  end
end
