require 'sinatra'
require 'json'
require 'erb'

get '/hi/:arg' do 
  "Why hello there, #{params[:arg].capitalize}!"
end

post '/seedBC' do
  erb :auth_payload, :locals => {:access_token => params[:access_token] }
  erb :auth_payload, :locals => {:email => params[:email] }
end

post '/oauth2/token' do
  puts "\n\nparams are: \n#{params}\n\n"
  erb :auth_payload, :locals => {:access_token => "asdlfkjasd0923rojasdflkjadsf"}
  erb  :auth_payload, :locals => {:email => "thing@guy.com"}
  erb :auth_payload, :locals => {:scope => params["scope"] }
  erb :auth_payload, :locals => {:id => params["client_id"] }
  erb :auth_payload, :locals => {:context => params["context"] }
end
