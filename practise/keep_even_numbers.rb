#!/usr/bin/env ruby

class Array

	def keep_even
		self.select { |n|  n%2==0 }
	end

	def keep_odd
		self.select { |n| n%2!=0}
	end

end


puts [ 1 ,2 ,3 ,4 ,5 ,6 ].keep_even
puts [ 1 ,2 ,3 ,4 ,5 ,6 ].keep_odd
