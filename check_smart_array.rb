#!/usr/bin/env ruby
#
# Nagios check for Smart Array (all models supported by hpacucli)
# Author: Eugenio Marzo

require 'optparse'

EXIT_OK = 0
EXIT_WARNING = 1
EXIT_CRITICAL = 2
EXIT_UNKNOWN = 3

if (ARGV[0].to_s[0] != "-")
 puts "Invalid Argument"
 exit EXIT_WARNING
end


OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-h", "--help", "Show help") do |h|
    puts "Usage: " +  File.basename(__FILE__).to_s + " --slot SLOT_NUMBER " 
    exit EXIT_WARNING 
  end

 opts.on("-v", "--version", "Show version") do |v|
    puts "Version 1.0"
    exit EXIT_WARNING
 end
 
 opts.on("-s S", "--slot S", Float ) do |s|
    SLOT=s.to_i
 end

end.parse!


check_status = `hpacucli ctrl  slot=#{SLOT}  show status`
check_array = `hpacucli ctrl  slot=#{SLOT}  show config`

check_status.split("\n").each do |line|
 if line  =~ /^.*Status.*$/   and   not line =~ /.*OK.*/
    puts line
    exit EXIT_WARNING
  end
end


check_array.split("\n").each do |line|
 if line  =~ /^.*array.*$|^.*logicaldrive.*$|^.*physicaldrive.*$/   and  not (line =~ /.*OK.*/  or  line =~  /.*Unused.*/ )
    puts line
    exit EXIT_WARNING
  end
end


puts "Smart Array OK"
exit EXIT_OK

