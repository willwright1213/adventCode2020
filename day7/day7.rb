
def findTheGoldenBag(root_bag, bag_color)
  isFound = false;
  if(root_bag.fetch(bag_color).has_key?("shiny gold"))
    isFound = true
  end

  root_bag.fetch(bag_color).each{ |key, value|
    if(root_bag.has_key?(key))
      while(!isFound)
        if(findTheGoldenBag(root_bag, key)) 
          isFound = true
        end
        break
      end
      if(isFound) 
        return true
      end
    end
  }
  return false
end


def findBagsInGoldenBag(root_bag, bag_color, val = 1, sum = 0)
  root_bag.fetch(bag_color).each{|key, value|
    value = value * val
    sum = value + findBagsInGoldenBag(root_bag,key,value,sum)
  }
  return sum
end


root_bag = Hash.new

File.foreach("input.txt"){ |line|

  child_bag = Hash.new
  objects = line.split(" ")
  root_bag_color = objects[0].to_s + " " + objects[1].to_s
  number = line.scan(/\d+/)

  for i in 0..number.length - 1
    value = objects[4 + (i*4)]
    color = objects[5 + (i*4)] + " " + objects[6 + (i*4)]
    child_bag[color] = value.to_i
  end

  root_bag[root_bag_color] = child_bag


}

#itteration for part 1
count = 0
root_bag.each{|key, value|
  if(findTheGoldenBag(root_bag, key))
    count += 1
  end
}

puts count
puts findBagsInGoldenBag(root_bag, "shiny gold")