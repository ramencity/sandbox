require 'sinatra'
require 'json'

#class MockBigCommerce 

   #attr_accessor :access_token,  :email
 
  get "/status" do
    "hey I am alive!"
  end

 post '/sendTokenAndEmail' do
    # I don't like class vars either, but it doesn't work as instance vars in Sinatra (every web call is a new instance)
    # And I couldn't get this to work with updating vars in an .erb template either
    @access_token = params[:access_token]
    @email = params[:email]
	"hey, my access token is: #{@access_token}"
 end


 post '/oauth2/token' do
    #authserver should send string like:
    # client_id=236754&client_secret=m1ng83993rsq3yxg&code=qr6h3thvbvag2ffq&scope=store_v2_orders&grant_type=authorization_code&redirect_uri=https://app.example.com/oauth&context=stores/g5cd38
    #Big Commerce should respond with:
    #"{\n"access_token": "g3y3ab5cctiu0edpy9n8gzl0p25og9u",\n"scope": "store_v2_orders",\n"user": {\n"id": 24654,\n"email": "merchant@mybigcommerce.com"\n},\n"context": "stores/g5cd38"\n}"
    return_message = {}
    return_message[:access_token] = @access_token
    return_message[:scope] = params["scope"]
    return_message[:user] = {}
    return_message[:user][:id] = params["client_id"]
    return_message[:user][:email] = @email
    return_message[:context] = params["context"]
    return_message.to_json
 end
