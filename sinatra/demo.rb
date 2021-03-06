require 'erb'
require 'json'
require 'sinatra'
require 'sinatra/reloader' #if you have installed gem 'sinatra-contrib'
require 'thin'
require 'tilt/erb'
Thin::HTTP_STATUS_CODES[418] = "I am a teapot"

#basic GET call:
get "/status" do
  "\nCongratulations! You're in flavor country"
end

#you can overwrite a default successful status code with a different code:
get "/unallowed" do
  status 401
  "You need auth to get in here."
end

# you can wildcard part of the uri.
# eg a GET call to 127.0.0.1:4567/users/7777/status:
get "/users/*/status" do
  "Status: OK"
end

# you can name and use params from the uri, rather than using a wildcard
# given a GET call to 127.0.0.1:4567/say/howdy/to/winston:
get "/say/:greeting/to/:user" do
  "Apparently you want me to say '#{params['greeting']}' to #{params['user'].capitalize}.  Done!"
end

# similarly, you can get and use params from post form data coming in from the client.
# assuming a call like: http -f PUT 127.0.0.1:4567/book/1234/author first_name=Robert last_name=Walser
put "/book/:book_id/author" do
  "Updated book #{params['book_id']} with author: #{params['first_name']} #{params['last_name']}"
end

# get and use data from IO stream, eg a JSON body, using the #read method
# assuming a POST call like: http -f POST 127.0.0.1:4567/add/product < product.json
post '/add/product' do
  status 201
  data = JSON.parse(request.body.read)
  id = data['id']
  asin = data['product_codes']['asin']
  title = data['title']
  "\nCongratulations! You've listed product id #{id} - '#{title}', asin: #{asin}"
end

#you can define and populate a small, inline erb template directly in the block:
get "/inline" do
  code = "Time is: <%= Time.new %>"
  code += "<%= '\nOrder confirmed!' %>"
  erb code
end

# or use a stand-alone erb template, located in a ./views subdirectory:
# assuming a POST call like: 127.0.0.1:4567/update/8888/status/shipped  tracking_number=Z7777777 ship_method=UPSGround
post "/customer/:customer_id/order/:order_id/status/:order_status" do
  @customer_id = params['customer_id']
  @order_id = params['order_id']
  @status = params['order_status']
  @tracking_number = params['tracking_number']
  @ship_method = params['ship_method']
  erb :order_update
end

# you can have an endpoint simply return a status code; and update the status code's text, as above in the top of the file
# although overriding default HTTP standard text is generally frowned upon
get "/java" do
  418
end
