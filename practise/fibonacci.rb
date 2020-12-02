#!/usr/bin/env ruby


# n      0	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15 
# fib(n) 0	1	1	2	3	5	8	13	21	34	55	89	144	233	377	610

def fib(n)
    
    seq = []
    idx = 0
    loop do 
        
        if idx == 0 
           seq.push(0) 
        elsif idx == 1
           seq.push(1) 
        else
            seq[idx] = seq[idx-1] + seq[idx-2]
        end

        break if idx == n
        idx +=1
    end

    return seq

end


def fib_req(n)
    return 0 if n == 0
    return 1 if n == 1
    ret = fib_req(n-1) + fib_req(n-2)
    return ret
end

puts "Without recursion"
puts fib(15)
puts
puts "With recursion"
puts fib_req(14)
