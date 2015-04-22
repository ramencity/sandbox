require 'erb'
require 'json'
require 'sinatra'
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
get '/say/:greeting/to/:user' do
  "Apparently you want me to say '#{params['greeting']}' to #{params['user'].capitalize}.  Done!"
end

# similarly, you can get and use params from post form data coming in from the client.
# assuming a POST call like: 127.0.0.1:4567/author first_name=Robert last_name=Walser book_id=1234
post '/author' do
  "Updated book #{params['book_id']} with author: #{params['first_name']} #{params['last_name']}"
end

# get and use data from IO stream, eg a JSON body, using the #read method:
post '/howdy' do
  #data = JSON.parse(request.body.read)
  'hi'
end

#you can define and populate a small, inline erb template directly in the block:
get "/inline" do
  code = "Time is: <%= Time.new %>"
  code += "<%= '\nOrder confirmed!' %>"
  erb code
end

# or use a stand-alone erb template, located in a ./views subdirectory:
# assuming a POST call like: 127.0.0.1:4567/update/8888/status/shipped  tracking_number=Z7777777 ship_method=UPSGround
post "/update/:order_id/status/:order_status" do
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
