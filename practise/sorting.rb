#!/usr/bin/env ruby


require 'pp'

class Tree

	include Enumerable
	attr_accessor :left, :data, :right

	# print with enumerables
	def each(&block)
		@left.each(&block) if @left	
		block.call(@data)
		@right.each(&block) if @right
	end


	def initialize(d)
		@data = d
	end

	def insert(d)
		if d > @data 
			@left ? ( @left.insert(d) ) : ( @left = Tree.new(d) )
		else
			@right ? ( @right.insert(d) ) : ( @right = Tree.new(d) )
		end
	end


	# print without enumerables 
	def printing
		@right.printing if @right
		puts @data
		@left.printing if @left
	end

end



t = Tree.new(5)

t.insert(6)
t.insert(10)
t.insert(1)
t.insert(12)


t.printing



t.each { |y|  puts y } 
