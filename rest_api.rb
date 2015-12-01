#!/usr/bin/env ruby


# http://www.andrewhavens.com/posts/20/beginners-guide-to-creating-a-rest-api/
# http://www.sitepoint.com/uno-use-sinatra-implement-rest-api/

require 'sinatra'
require 'json'
require 'pp'

class Foo

        attr_accessor :data

        def initialize
                @data = {
                                'abhisawa' => 'blah blah',
                                'ps' => 'aa aa'
                        }
        end


        def list
                JSON.pretty_generate(@data)
        end

        def get(k)
                JSON.pretty_generate({ k => @data[k] }) if @data.has_key?(k)
        end

        def create(h)
                @data.merge!(h)
        end


end



n = Foo.new

# curl http://localhost:4567/list
get '/list' do
        n.list
end

# curl  http://localhost:4567/get?k=param1
get '/get' do
        if params.has_key?('k')
                n.get(params['k'])  || '{}'
        else
                return status 400
        end
end


# curl  http://localhost:4567/create  -d 'param1=value1&param2=value2'
post '/create' do
        n.create(params)
        return  status 201
end

#HTTP Status Codes
#
#2xx = Success
#3xx = Redirect
#4xx = User error
#5xx = Server error
#Here's a list of the most important status codes:
#
#Success codes:
#
#200 - OK (the default)
#201 - Created
#202 - Accepted (often used for delete requests)
#User error codes:
#
#400 - Bad Request (generic user error/bad data)
#401 - Unauthorized (this area requires you to log in)
#404 - Not Found (bad URL)
#405 - Method Not Allowed (wrong HTTP method)
#409 - Conflict (i.e. trying to create the same resource with a PUT request)
