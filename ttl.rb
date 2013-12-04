acquiredAt = Time.new()
  puts "What is the count of competitive offers?"
offers = gets.chomp.to_i
  puts "What is the item's sales rank?"
rank = gets.chomp.to_i
  puts "What is the Cache Lifetime Multiplier? (Hint: 1.0 = default)"
lifeMult = gets.chomp.to_i

lifespan = (3600 * lifeMult * (Math.log(1 + rank) + (3.0 * Math.log(1+offers))))
  puts "Lifespan in seconds is " + lifespan.to_s
maxCache = (120 * 3600)  
ttl = [lifespan, maxCache].min

convertTtl = Time.at(ttl).utc.strftime("%Hh %Mm %Ss")
  puts "TTL in hours is " + convertTtl
expireTime =  acquiredAt + ttl
  puts "TTL expires at " + expireTime.to_s

puts "What is the offer source?  Enter: apes, mina or other"
source = gets.chomp.downcase
if source == "apes"
  @multiplier = 0.5
elsif source == "mina"  
  @multiplier = 0.5
else @multiplier = 1.0
end  

expireHours = ttl * @multiplier
expireConvert =  Time.at(expireHours).utc.strftime("%Hh %Mm %Ss")
  puts "expiration after considering multipliers is " + expireConvert
expireTime = acquiredAt + expireHours  
  
recovery = Time.new() + (6*3600)
  puts "recovery time is " + recovery.to_s
  puts "Were these offers obtained via fallback mechanism?  Answer: y or n"
isFallback = gets.chomp.downcase
if isFallback == "y"
  nuExpiry = [expireTime.to_i, recovery.to_i].max
elsif isFallback == "n"
  nuExpiry = expireTime
end 

puts "New expiry after considering fallback case is " + Time.at(nuExpiry).to_s
