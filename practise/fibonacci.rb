#!/usr/bin/env ruby


require 'pp'

( 0 .. 20 ).inject(Array.new) do |a,b|

	if a.length < 2
		a.push(b)
	else

		
		last = a.shift
		o_last = a.shift
		now = last + o_last
		a = [ now , last ]
		puts now
	end
	a
end


