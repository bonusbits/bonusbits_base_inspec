require_relative '../helpers/os_queries'

configure_firewall = attribute('configure_firewall', default: false, description: 'Configure Firewall')

base_iptables_rules = %w(
  -p tcp -m tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
  -m state --state RELATED,ESTABLISHED -j ACCEPT
  -i lo -j ACCEPT
  -p tcp -m tcp --dport 873 -m state --state NEW,ESTABLISHED -j ACCEPT
)

default_iptables_chains = %w(
  INPUT
  OUTPUT
  FORWARD
)

if rhel_family? && !docker?
  if configure_firewall
    describe 'IP Tables' do
      it 'Base Rules Configured' do
        expect(iptables).to have_rule('-P INPUT DROP')
        base_iptables_rules.each do |rule|
          expect(iptables(chain: 'input')).to have_rule(rule)
        end
      end
    end
  else
    # Verify Default Iptables Configuration
    describe 'IP Tables' do
      default_iptables_chains.each do |chain|
        it "-P #{chain} ACCEPT" do
          expect(iptables).to have_rule("-P #{chain} ACCEPT")
        end
      end
    end
  end
end

if os.windows?
  # Place Holder
end
