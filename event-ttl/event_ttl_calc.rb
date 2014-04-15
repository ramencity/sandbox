require 'time'

puts 'Give me the EventTriggeredAt timestamp from CachedOfferSource:'
timestring = gets.chomp + ' UTC' #add 'UTC' to the string because the date is in UTC but Time.parse thinks it is local
triggered_at = Time.parse(timestring)

puts 'Now give me the TimeToLive (in seconds):'
ttl = gets.chomp.to_i

offer_expiry = triggered_at + ttl

puts 'the offer expires at ' + offer_expiry.to_s
