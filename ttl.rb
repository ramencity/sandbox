  puts "What is the count of competitive offers?"
offers = gets.chomp.to_i
  puts "What is the item's sales rank?"
rank = gets.chomp.to_i
  puts "What is the Cache Lifetime Multiplier? (Hint: 1.0 = default)"
constant = gets.chomp.to_i

lifespan = (3600 * constant * (Math.log(1 + rank) + (3.0 * Math.log(1+offers))))
  puts "Lifespan in seconds is " + lifespan.to_s
maxCache = (120 * 3600)  
ttl = [lifespan, maxCache].min

converted = Time.at(ttl).utc.strftime("%Hh %Mm %Ss")
  puts "TTL in hours is " + converted
expireTime =  Time.new() + ttl
  puts "TTL expires at " + expireTime.to_s
