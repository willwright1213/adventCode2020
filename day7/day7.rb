

def findBagsInGoldenBag(root_bag, bag_color, val, sum)
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
