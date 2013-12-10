#acquiredAt = (Time.new.utc() - (2*3600))
acquiredAt = Time.utc(2013,12,9,21,00,00) 
  puts "What is the count of competitive offers?"
offers = gets.chomp.to_i
  puts "What is the item's sales rank?"
rank = gets.chomp.to_i
  puts "What is the Cache Lifetime Multiplier? (Hint: 1.0 = default)"
lifeMult = gets.chomp.to_i

lifespan = (3600 * lifeMult * (Math.log(1 + rank) + (3.0 * Math.log(1 + offers))))
  puts "Lifespan is initially " + Time.at(lifespan).utc.strftime("%Hh %Mm %Ss")

maxCacheLifetimeInHours = 120
maxCacheCap = (maxCacheLifetimeInHours * 3600)
  
ttl = [lifespan, maxCacheCap].min
  puts "TTL in hours (after considering max cap) is " + Time.at(ttl).utc.strftime("%Hh %Mm %Ss")

expireTime =  acquiredAt + ttl
  puts "Based on acquired time of " + Time.at(acquiredAt).to_s + ", TTL would expire at " + expireTime.to_s

apesTTLMultiplier = 0.5
minaTTLMultiplier = 0.5

puts "What is the offer source?  Enter: apes, mina or other"
source = gets.chomp.downcase
if source == "apes"
  @multiplier = apesTTLMultiplier
elsif source == "mina"
  @multiplier = minaTTLMultiplier
else @multiplier = 1.0
end

expireHours = ttl * @multiplier
expireConvert =  Time.at(expireHours).utc.strftime("%Hh %Mm %Ss")
  puts "TTL in hours after considering source is " + expireConvert
expireAt = acquiredAt + expireHours

recoveryTTLHours = 6
recovery = Time.new.utc() + (recoveryTTLHours * 3600)
  puts "Recovery time from fallback scenario would be " + recovery.to_s
  puts "Were these offers obtained via fallback mechanism?  Answer: y or n"
isFallback = gets.chomp.downcase
if isFallback == "y"
  newExpiry = [expireAt, recovery].max
elsif isFallback == "n"
  newExpiry = expireAt
end

puts "Expiry after considering fallback case is " + Time.at(newExpiry).to_s

minTTLHours = 2
cacheUntil = [newExpiry, (Time.new.utc() + (minTTLHours * 3600))].max
  puts "Final client cache expiry after considering acquired time vs minimum TTL is: " + Time.at(cacheUntil).to_s

#Service Cache Expiration Calculation:

apesReacquireMultiplier = 2.0
if source == "apes"
  @svcFreshness = ttl * apesReacquireMultiplier
else @svcFreshness = ttl
end

freshUntil = acquiredAt + @svcFreshness
  puts "Service's internal TTL is " + Time.at(freshUntil).to_s
