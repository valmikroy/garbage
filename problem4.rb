#!/usr/bin/ruby
require 'pp'

puts "Provide reperative string "
string = gets

string.chomp!

#z = string.split(//).inject(Hash.new(0)) { |a,b| a[b]=a[b]+1 ; a  }
z = string.split(//).inject(Hash.new(0)) { |a,b| pp a ;  a[b]=a[b]+1 ; a }

pp z
