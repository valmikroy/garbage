#!/usr/bin//env ruby

# Test input 
# 1:30
# 6:10 , 1:5
# 10:20 , 1:5
# 10:20  ,  1:5 , 6: 9
# 50:60, 40:50 , 30:40, 20:30,1:5
# 1:10,17:30,5:15
# 3:5,4:6,5:7,1:20
# 1325376000000: 1330560000000, 1328054400000: 1338508800000, 1343779200000: 1354320000000, 1354320000000: 1417392000000



# Test output
# 1:30
# 1:10
# 1:5,10:20
# 1:20
# 1:5,20:60
# 1:15,17:30
# 1:20
# 1325376000000:1338508800000,1343779200000:1417392000000

class Tree

        attr_accessor :left, :min, :max, :right
        def initialize(d)
                self.min = d.split(/\s*:\s*/)[0].to_i
                self.max = d.split(/\s*:\s*/)[1].to_i
        end

        def insert(d)

                min = d.split(/\s*:\s*/)[0].to_i
                max = d.split(/\s*:\s*/)[1].to_i



                if max < self.min && min < self.min
             #       puts "another node on left"
                    self.left  ? ( self.left.insert(d) ) : ( self.left = Tree.new(d) ) 
                elsif  min > self.max && max > self.max
             #       puts "another node on right"
                    self.right ? ( self.right.insert(d) ) : ( self.right = Tree.new(d) ) 
                elsif ( min > self.min )  && ( max < self.max )
             #       puts "--it is in range"
                elsif  ( min < self.min ) && ( max < self.max )
             #       puts "expand left"
                    self.min = min 
                elsif  min > self.min && max > self.max
             #       puts "expand right"
                    self.max = max
                elsif min < self.min && max > self.max
             #       puts "expand both sides"
                    self.min = min
                    self.max = max
                end

        end

        def gather(c)
                self.left.gather(c) if self.left
                c.push("#{self.min}:#{self.max}")
                self.right.gather(c) if self.right
        end


end


# take input and expand range
input = gets.chomp.split(/\s*,\s*/)


# insert in tree and sort
x = Tree.new(input.shift)
input.each { |i| x.insert(i) }
c = []
x.gather(c)

puts c.join(' ')


