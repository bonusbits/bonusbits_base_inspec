require_relative '../helpers/os_queries'

debug = input('debug', value: false, description: 'Enable Debugging')

if debug
  puts "DEBUG: Amazon Linux 1?           (#{amazon_linux1?})"
  puts "DEBUG: Amazon Linux 2?           (#{amazon_linux2?})"
  puts "DEBUG: Amazon Linux?             (#{amazon_linux?})"
  puts "DEBUG: Docker?                   (#{docker?})"
  puts "DEBUG: EC2                       (#{ec2?})"
  puts "DEBUG: Inside AWS                (#{aws?})"
  puts "DEBUG: Linux?                    (#{os.linux?})"
  puts "DEBUG: OS Arch                   (#{os[:arch]})"
  puts "DEBUG: OS Family                 (#{os[:family]})"
  puts "DEBUG: OS Name                   (#{os[:name]})"
  puts "DEBUG: OS Platform               (#{os[:platform]})"
  puts "DEBUG: OS Release                (#{os[:release]})"
  puts "DEBUG: Ubuntu?                   (#{ubuntu?})"
end
