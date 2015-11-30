#!/usr/bin/env ruby

# Articles refered http://www.mikeperham.com/2014/11/26/building-a-binary-tree-with-enumerable/

require 'pp'

class Node
        include Enumerable
        attr_accessor :data, :left, :right

        def initialize(d)
                @data = d
        end

        def each(&block)
                right.each(&block) if right
                block.call(self)
                left.each(&block) if left
        end

        def insert(d)
                if d < data
                        left.insert(d) if left
                        @left = Node.new(d) unless left
                else
                        right.insert(d) if right
                        @right = Node.new(d) unless right
                end
        end

end


root = Node.new(5)

root.insert(10)
root.insert(11)
root.insert(110)
root.insert(1)
root.insert(2)

root.each {|y|  puts y.data }
