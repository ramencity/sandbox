puts "What is the count of competitive offers?"
offers = gets.chomp.to_i
puts "What is the item's sales rank?"
rank = gets.chomp.to_i
puts "What is the Cache Lifetime Multiplier? (Hint: 1.0 = default)"
constant = gets.chomp.to_i
ttl = (3600 * constant * (Math.log(1 + rank)  + (3.0 * Math.log(1+offers))))
puts "TTL in seconds is " + ttl.to_s
converted = Time.at(ttl).utc.strftime("%Hh %Mm %Ss")
puts "TTL in hours is " + converted
cached = Time.new() + ttl
puts "Cache expires at " + cached.to_s