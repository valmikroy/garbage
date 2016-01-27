#!/usr/bin/env ruby


require   'pp'




puts "string reperation"
str = gets.chomp

z = str.split(//).inject(Hash.new(0)) { |a,b| a[b] = a[b] + 1  ; a  } 


z.each {|k,v| puts "#{k}x#{v}"}
