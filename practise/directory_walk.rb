#!/usr/bin/env ruby


#We want to find files that have the exact same contents, byte for byte, within a given directory. Write a function that takes a path and returns a list of lists or sets. Each set should contain files that have the same content.
#
#An example output is for the input '/foo/' is:
#
#[
#  ['/foo/bar.png', '/foo/images/foo.png'],
#  ['/foo/file.tmp', '/foo/other.temp', '/foo/temp/baz/that.foo']
#]


require 'digest'
require 'pp'

@d = Hash.new



def a(path)
	x = Digest::SHA256.file path
	sha1 = x.hexdigest
	@d[sha1]  = [] unless @d.has_key?(sha1)
	@d[sha1].push(path)
end

def walk(d)

	Dir.foreach(d) do |x|
		next if x == '.'  || x == '..'
		path = "#{d}/#{x}"
		walk(path) if File.directory?(path)
		next  if File.directory?(path)
		a(path)
	end
end





walk('/Users/abhisawa/git') 
# print only duplicates
@d.each { |k,v| puts v.join('  ')  if v.count > 1   }

