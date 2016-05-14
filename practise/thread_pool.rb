#!/usr/bin/env ruby

require 'mixlib/shellout'
require 'benchmark'



def exec!(*command)
	cmd = Mixlib::ShellOut.new(*command)
	cmd.run_command
	cmd.error!
	cmd
end

# Simple function
def dumb(x)

	#word = 'blah'
	#url="https://www.google.com/?gws_rd=ssl#q=#{word}"
	#exec!("curl -i /dev/null '#{url}'")
    [128000+x].pack "U*"
    #print " #{x} " 
end
	

# Repeat some task for 1000 times
def threadpool


    # work queue defines 1000 times iteration
	work_q = Queue.new
	(0...999).to_a.each { |i| work_q << i }

	t = []
	puts Benchmark.measure{
        # we spawn only 5 threads
		t = (0...4).map do 
			Thread.new do
				begin 
                    # before taking any action 
                    # thread try to pop from work queue
                    # if work queue is empty then 
                    # threaderror exception get raised
					while x = work_q.pop(true)
						#puts x
						dumb(x) 
					end
				rescue ThreadError
				end
			end	
		end
		t.each { |x| x.join }
	}

end

def threads_only

    t = []
    puts Benchmark.measure {
        # plain 1000 threads 
        1000.times do |x|
            t << Thread.new do
                dumb(x)
            end    
        end
        t.each { |x| x.join }
    }

end



threadpool

threads_only
