require 'sinatra'
require 'json'
require 'thin'
Thin::HTTP_STATUS_CODES[418] = "I am a teapot"
Thin::HTTP_STATUS_CODES[207] = "I am napping"

get '/say/*/to/*' do
  # matches /say/hello/to/world
  #params['splat'] # => ["hello", "world"]
  "Apparently you want me to say '#{params['splat'][0]}' to #{params['splat'][1].capitalize}.   Done."
end

#are these all GET calls??
#recall: put the most specific endpoint first - Sinatra will match to the first endpoint in the list it can match to

get "/stores/*/v2/orders/*/shipments/count" do
  "The shipment count for order # #{params['splat'][1]} is..oh, let's say, 2"
end

get "/stores/*/v2/orders/*/shipments" do
  "I guess you want the shipments for order # #{params['splat'][1]}"
end

get "/stores/*/v2/orders/*" do
  "Ok, here is order #{params['splat'][1]} for you!"
end

post "/stores/*/v2/orders/*" do
  @tracking_message = ''
  if params["tracking_number"] 
    then @tracking_message = "with tracking number: #{params["tracking_number"]}"
  end
  "thank you for updating order #{params['splat'][1]} #{@tracking_message}"
end

#but isn't this better than wildcards?  Seems like it!
post "/stores/:id/v2/pickup/:package" do
  "Welcome back, #{params['id']}, your package '#{params['package']}' is ready for you!"
end

get "/java" do
  418
end

get "/soTired" do
  207
end
