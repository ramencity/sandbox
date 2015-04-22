require 'sinatra'
require 'json'
require 'erb'

get "/something" do
  erb :something
end

get "/inline" do
  code = "Time is: <%= Time.new %>"
  code += "<%= '\n\nlegerdemain!' %>"
  erb code
end

post "/auth" do
  @access_token = params[:access_token] 
  @scope = params[:scope] 
  @id = params[:id]
  @email = params[:email]
  @context = params[:context]
  erb :auth
end
 
 post "/seeder" do
   @@access_token = params[:access_token] 
   @@email = params[:email]
 end
 
 post "/auth2" do 
   @scope = params[:scope]
   @id = params[:id]
   @context = params[:context]
   erb :auth2
 end

post '/oauth2/token' do
  @scope = params[:scope]
  @id = params[:id]
  @context = params[:context]
  erb :auth2
end
