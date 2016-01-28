#!/usr/bin/env ruby

require 'thread'


t = []


m = Mutex.new

200.times do |i|

	t << Thread.new do 

		m.synchronize  do
			puts i
		end
	end

end

t.map { |x|  x.join }

