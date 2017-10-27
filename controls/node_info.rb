require_relative '../helpers/os_queries'

configure = attribute('configure_node_info', default: true, description: 'Configure Node Info').to_s.eql?('true') ? true : false

debug = attribute('debug', default: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false
puts "ATTR: Configure NodeInfo     (#{configure})" if debug

if configure
  if os.linux?
    describe 'Nodeinfo Script' do
      it '/usr/local/bin/nodeinfo' do
        expect(file('/usr/local/bin/nodeinfo')).to exist
      end
    end
  elsif os.windows?
    describe 'Nodeinfo Script' do
      it 'C:/Windows/System32/nodeinfo.cmd' do
        expect(file('C:/Windows/System32/nodeinfo.cmd')).to exist
      end
    end
  end
end
