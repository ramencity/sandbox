acquiredAt = (Time.new() - (24*3600))
  puts "Item was acquired at " + Time.at(acquiredAt).to_s
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
  puts "TTL would expire at " + expireTime.to_s

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
  puts "expiration hours after considering multipliers is " + expireConvert
expireTime = acquiredAt + expireHours  
  
recoveryHours = 6
recovery = Time.new() + (recoveryHours * 3600)
  puts "recovery time from fallback scenario would be " + recovery.to_s
  puts "Were these offers obtained via fallback mechanism?  Answer: y or n"
isFallback = gets.chomp.downcase
if isFallback == "y"
  nuExpiry = [expireTime.to_i, recovery.to_i].max
elsif isFallback == "n"
  nuExpiry = expireTime
end 

puts "New expiry after considering fallback case is " + Time.at(nuExpiry).to_s

minTTLHours = 2
cacheUntil = [nuExpiry.to_i, (Time.new() + (minTTLHours * 3600)).to_i].max
  puts "Final client cache after considering acquired time vs minimum TTL is: " + Time.at(cacheUntil).to_s