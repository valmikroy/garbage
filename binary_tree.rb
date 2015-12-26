#!/usr/bin/env ruby
 
require 'pp'
 
def build_tree( n , d )
 
        if d.key?('v')
                n < d['v']  ? build_tree(n , d['l']) :  build_tree(n, d['r'])
        else
                d['l'] = {}
                d['v'] = n
                d['r'] = {}
        end
 
end
 
def print_tree(d)
 
        print_tree(d['l']) if d.key?('l')
        print  "#{d['v']}," if d.key?('v')
        print_tree(d['r']) if d.key?('r')
 
end
 
 
def get_tree_height(d,cnt = 0 )
 
        if ( d['l'] == {} && d['r'] == {} )
                @depth = cnt if @depth < cnt
        else
                cnt = cnt + 1
                get_tree_height(d['l'],cnt) if  d.key?('l')
                get_tree_height(d['r'],cnt) if d.key?('r')
        end
 
        return @depth
 
end
 
 
def no_recurse_print_tree(data)
 
        begin
 
                @current = data if  @current.nil?
                if @current.key?('l')
                        @stack.push( { 'v'  => @current['v'] , 'ptr' => @current['r']  }  )
                        @current = @current['l']
                elsif ! ( @current.key?('l') && @current.key?('r') )
                        if @stack.length > 0
                                tmp = @stack.pop
                                print  "#{tmp['v']},"
                                @current=tmp['ptr']
                        else
                                @current = nil
                        end
                end
 
        end while ! @current.nil?
        puts
 
end
 
data = {}
[50,25,75,12,37,6,18,3,9,15,21, 21,43,28,34,40,46,62,87,56,68,53,59,65,71,81,93,78,84,90,96 ].each do |x|
        build_tree(x,data)
end
 
 
 
@stack = []
@current = nil
no_recurse_print_tree(data)
print_tree(data)
puts
@depth = 0
puts get_tree_height(data) 
