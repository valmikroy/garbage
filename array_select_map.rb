#!/usr/bin/ruby
require 'pp'

#Given the following list: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
#Create a function that takes in a list, and returns a list of lists where one list contains even numbers, and the other contains odd numbers:
#End result should be: [[2, 4, 6, 8, 10], [1, 3, 5, 7, 9]]

[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].each {|num|  puts num }
puts "=================================="

class Array

	def keep_even
		self.select{ |num| num%2==0 }	
	end
end

a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
puts a.keep_even
puts "=================================="


puts a.select { |n|  n%2!=0 }


puts "=================================="
a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
z = a.map { |n| n**2 }
x = a.collect { |n| n**2 }
puts z
puts x
puts a

puts "=================================="

a=[[],[]]
a[0] =  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].select{|n| n%2==0 }
a[1] =  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].select{|n| n%2!=0 }

pp a
puts "=================================="

z = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].group_by {|n| n%2 }
a = [ z[0] , z[1] ]
pp a
