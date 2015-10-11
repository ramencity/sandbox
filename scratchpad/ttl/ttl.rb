def seconds_to_units(seconds)
  '%d days, %d hours, %d minutes, %d seconds' %
    # the .reverse lets us put the larger units first for readability
    [24,60,60].reverse.inject([seconds]) {|result, unitsize|
      result[0,0] = result.shift.divmod(unitsize)
      result
    }
end

#acquiredAt = (Time.new.utc() - (7*3600))
acquiredAt = Time.utc(2014,1,15,15,14,40) 
  puts "What is the count of competitive offers?"
offers = gets.chomp.to_i
  puts "What is the item's sales rank?"
rank = gets.chomp.to_i
#  puts "What is the Cache Lifetime Multiplier? (Hint: 1.0 = default)"
#cacheLifetimeMultiplier = gets.chomp.to_f

#initial lifespan calculation:
cacheLifetimeMultiplier =  1

lifespan = (3600 * cacheLifetimeMultiplier * (Math.log(1 + rank) + (3.0 * Math.log(1 + offers))))
  puts "Lifespan is initially " + seconds_to_units(lifespan)

maxCacheLifetimeInHours = 120
maxCacheCap = (maxCacheLifetimeInHours * 3600)

ttl = [lifespan, maxCacheCap].min
  puts "TTL in hours (after considering max cap of " + maxCacheLifetimeInHours.to_s + " hours) is " + seconds_to_units(ttl)

expireTime =  acquiredAt + ttl
  puts "Based on acquired time of " + Time.at(acquiredAt).to_s + ", TTL would expire at " + expireTime.to_s

apesTTLMultiplier = 1 #cuz of bug that is still in Dev... where float is rounded up to 1
minaTTLMultiplier = 0.5

puts "What is the offer source?  Enter: apes, mina or other"
@source = gets.chomp.downcase
if @source == "apes"
  @multiplier = apesTTLMultiplier
elsif @source == "mina"
  @multiplier = minaTTLMultiplier
else @multiplier = 1.0
end

expireHours = ttl * @multiplier
#expireConvert =  seconds_to_units(expireHours)
  puts "TTL in hours after considering source is " + seconds_to_units(expireHours)
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

apesReacquireMultiplier = 8.0

if @source == "apes"
  @svcFreshness = ttl * apesReacquireMultiplier
  else @svcFreshness = ttl
end

freshUntil = acquiredAt + @svcFreshness
  puts "Service's internal TTL is " + Time.at(freshUntil).to_s
