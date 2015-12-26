#!/usr/bin/env ruby
 
require 'pp'
 
# Building binary tree from given array
# Every node has left , right and value variable
# left and right are pointers to another node
# depedending on condition traverse till you reach leaf which does not have value variable
# there you create new leaf
def build_tree( n , d )
 
        if d.key?('v')
                n < d['v']  ? build_tree(n , d['l']) :  build_tree(n, d['r'])
        else
                d['l'] = {}
                d['v'] = n
                d['r'] = {}
        end
 
end
 
# Printing tree is first recurse till leaft of left side of the root node
# then recurse to right
def print_tree(d)
 
        print_tree(d['l']) if d.key?('l')
        print  "#{d['v']}," if d.key?('v')
        print_tree(d['r']) if d.key?('r')
 
end
 
 
# count when you hit every nodes
# when you reach leaf , store that count to global counter
# next time when reach leaf again , check global counter if its less than current count of nodes above this leaf
# if yes, then update global counter with higher value
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
 
# Print binary tree without recursion
# Problem get divided as follows
# do while loop which will keep going on till all nodes get touched
# to keep track of current node in processing use @current
# if current node is not leaf then push that node value and its right pointer on @stack
# when you hit leaf which in our case blank hash {} with no value or left or right pointer ( check L15 above )
# that time pop right pointer and value our of stack and print value
# then make right pointer as @current node and loop over again
# when stack is empty , set @current to nil which would indicate that we have touched all nodes 
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
 
# breadth first where both left and right nodes need to be take care
# of first before moving to next level
# so recursion function takes array as input 
# as long as array has elements it will print value of each element and throw its left and right nodes on stack
# pass this built stack to same function to form recursion
def breadth_first(a=[])
        unless a.length == 0
                s = []
                a.each do |z|
                        if z.key?('v')
                                print "#{z['v']} "
                                s.push(z['l'])
                                s.push(z['r'])
                        end
                end
                breadth_first(s)
        end
 
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

breadth_first([data])
