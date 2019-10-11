require_relative '../helpers/os_queries'

debug = attribute('debug', value: false, description: 'Enable Debugging').to_s.eql?('true') ? true : false

if debug
  puts "ATTR: Inside AWS                (#{ec2?})"
  puts "ATTR: Amazon?                   (#{amazon_linux?})"
  puts "ATTR: Linux?                    (#{os.linux?})"
  puts "ATTR: OS Family                 (#{os[:family]})"
  puts "ATTR: OS Release                (#{os[:release]})"
  puts "ATTR: OS Platform               (#{os[:platform]})"
  puts "ATTR: OS Name                   (#{os[:name]})"
end
