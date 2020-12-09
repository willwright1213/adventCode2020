$preamble = []

def search_Intruder(i, size=i)
    val = $preamble[i]
    found = false
    for j in (i-size)..(i-2)
        for k in (i-(size + 1))..(i-1)
            sum = $preamble[j] + $preamble[k]
            if(sum == val)
                found = true
                break
            end
        end
        if(found)
            break
        end
    end
    if(found)
        i += 1
        search_Intruder(i, size)
    else
        return i
    end
end


def find_sum(i)
    start = $preamble[i]
    for j in 0..(i-1)
        sum = 0
        smallest = $preamble[i]
        biggest = 0
        for k in j..(j+(i-1))
            sum += $preamble[k]
            if($preamble[k] < smallest)
                smallest = $preamble[k]
            elsif($preamble[k] > biggest)
                biggest = $preamble[k]
            end
            if(sum == start)
                return smallest + biggest
            end
        end
    end
end

File.foreach("input.txt") { |line|
    $preamble.push(line.to_i)
}

puts $preamble[search_Intruder(25)]
puts find_sum(search_Intruder(25))
