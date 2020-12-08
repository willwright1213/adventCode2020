$instruction_list = []
$acc = 0

#this will attempt to fix the program and update the instruction list
#It itterates through the array of instruction to find every "nop" and "jmp".
#If found, it will alternate, check, and reset, until it finds the one that fix the loop
def fix
    for i in 0..($instruction_list.size - 1)
        if($instruction_list[i][0] == "nop")
            $instruction_list[i][0] = "jmp"
            if(!check_for_loop(0))
                return
            end
                reset
                $instruction_list[i][0] = "nop"
        end
    end
    for i in 0..($instruction_list.size - 1)
        if($instruction_list[i][0]  == "jmp")
            $instruction_list[i][0] = "nop"
            if(!check_for_loop(0))
                return
            end
                reset
                $instruction_list[i][0] = "jmp"
        end
    end
    return
end


#Execute the instructions and return $acc value
def execute(i)
    ind = i
    $instruction_list[ind][2] = true
    if($instruction_list[i][0] == "nop")
        ind += 1
    elsif($instruction_list[i][0] == "acc")
        $acc += $instruction_list[i][1]
        ind += 1
    else
        ind += $instruction_list[i][1]
    end
    if(i > $instruction_list.size - 2 || $instruction_list[ind][2] == true)
        return $acc
    end
    execute(ind)
end

#This checks if there's a loop going on in the code.
def check_for_loop(i)
    #execute instructions
    ind = i
    $instruction_list[ind][2] = true
    if($instruction_list[i][0] == "nop" || $instruction_list[i][0] == "acc")
        ind += 1
    else
        ind += $instruction_list[i][1]  
    end
    #check if there's a loop
    if(i > $instruction_list.size - 2)
        reset
        return false
    elsif($instruction_list[ind][2] == true)
        reset
        return true
    end
    check_for_loop(ind)
end

#reset acc to 0 and all visited instructions to false
def reset
    $acc = 0
    for i in 0.. ($instruction_list.size - 1)
        $instruction_list[i][2] = false
    end
end

#Scanning file input
File.foreach("input.txt") { |line| 

    instruction = []
    objects = line.split(' ')
    action_name =  objects[0]
    action_value = objects[1].match?('\+') ? objects[1].delete("+").to_i: -1 * objects[1].delete("-").to_s.to_i
    instruction.push(action_name)
    instruction.push(action_value)
    instruction.push(false)
    $instruction_list.push(instruction)
}

puts execute(0)
fix
puts execute(0)