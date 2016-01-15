#!/usr/bin/ruby

#Write a program which prints out all numbers between 1 and 100. When the program would print out a number exactly divisible by 4, #print "Linked" instead. When it would print out a number exactly divisible by 6, print "In" instead. When it would print out a #number exactly divisible by both 4 and 6, print "LinkedIn."

(1..100).to_a.each do  |c|  

#puts "LinkedIn" if c%4==0 && c%6==0
#puts "Linked" if c%4==0 && c%6!=0
#puts "In" if c%4!=0 && c%6==0

if c%4==0 && c%6==0
	puts "LinkedIn"
elsif c%4==0
	puts "Linked"
elsif c%6==0
	puts "In"
end




puts c if c%4!=0 && c%6!=0


end
