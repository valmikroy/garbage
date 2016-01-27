#!/usr/bin/env ruby



def by_word_reverse(a)
	w = a.shift
	by_word_reverse(a) if a.length > 0
	print w
	print " "
end

def by_char_reverse(a)
	w = a.shift
	by_char_reverse(a) if a.length > 0
	print w
end


puts "get string"
str = gets
str.chomp!

by_word_reverse(str.split(/\s+/))
puts
by_char_reverse(str.split(//))
puts
