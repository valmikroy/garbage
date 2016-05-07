#!/usr/bin/env ruby

require 'mixlib/shellout'
require 'benchmark'



def exec!(*command)
	cmd = Mixlib::ShellOut.new(*command)
	cmd.run_command
	cmd.error!
	cmd
end

def dumb

	word = 'blah'
	url="https://www.google.com/?gws_rd=ssl#q=#{word}"
	exec!("curl -i /dev/null '#{url}'")
end
	


def threadpool


	work_q = Queue.new
	(0...99).to_a.each { |i| work_q << i }

	t = []
	puts Benchmark.measure{
		t = (0...4).map do 
			Thread.new do
				begin 
					while x = work_q.pop(true)
						#puts x
						50.times{ dumb  }
					end
				rescue ThreadError
				end
			end	
		end
		t.each { |x| x.join }
	}

end
