#!/usr/bin/ruby
require 'pp'

#“Apple HQ is located in cupertino!” in input prompt
#Parse this string, and print the last two words of this string in reverse. Please avoid using [::­1] End result should be:
#“!onitrepuc ni” . Write full reversal and then try to improve with just last two reversed.


# feed array  of reversal
def r(s=[],b)
	c = s.shift		
	r(s,b) unless s.length == 0
	b << c
	return b
end


$count = 3
def reversal(s=[])
	c = s.shift
	reversal(s) unless s.length == 0
	$count -=1 if c.match(/\s/)
	print c  if $count > 0
end

x = "Apple HQ is located in cupertino!"

z = x.split(/\s+/)

a = []

r(z,a)


reversal(x.split(//))
puts
