#!/usr/bin/env  ruby

# if divisible by 4 then Linked

# if divisible by 6 then In

# divisible by both then LinkedIn

a = 20
b = 18

c = (a*b/(a-b))



( 1 .. 1000 ).each do |n|  
	# figured a rule 
	# (6*4/(6-4)) == 12 
	# if number divisible by 12 then it should be divisible by both
	if n%c == 0 
		puts "LinkedIn #{n}"
	elsif  n%b == 0
		puts "Linked #{n}"
	elsif  n%a == 0
		puts "In #{n}"
	else
		puts n
	end
end
