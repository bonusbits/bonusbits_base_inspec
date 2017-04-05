configure_node_info = attribute('configure_node_info', default: true, description: 'Configure Node Info').to_s.eql?('true') ? true : false

if configure_node_info
  if os.linux?
    describe 'Nodeinfo Script' do
      it 'has /usr/local/bin/nodeinfo' do
        expect(file('/usr/local/bin/nodeinfo')).to exist
      end
    end
  elsif os.windows?
    describe 'Nodeinfo Script' do
      it 'has C:/Windows/System32/nodeinfo.cmd' do
        expect(file('C:/Windows/System32/nodeinfo.cmd')).to exist
      end
    end
  end
end
