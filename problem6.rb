#!/usr/bin/ruby 

require 'pp'

f = '/var/log/auth.log'

#Oct 28 09:37:34 ip-172-31-0-29 sudo:   ubuntu : TTY=unknown
m = {}
File.readlines(f).each do |l|
	l.chomp!
	/^(\w+?\s\d{1,2}\s\d{2}:\d{2}):\d{2}\sip-\d{1,3}-\d{1,3}-\d{1,3}-\d{1,3}\s(\w+?):\s+/.match(l)
	puts $1
	m[$1] = { 'count' => 0 , 'proc' => [] }   unless m.has_key?($1)	
	m[$1]['count'] += 1
#	m[$1]['proc'] << $2  unless $2.nil?
end

#m.each {|k,v| puts "#{k},#{v['count']}" }
pp m
