require 'erb'
require 'json'
require 'sinatra'
require 'sinatra/reloader' #if you have installed gem 'sinatra-contrib'
require 'thin'
require 'tilt/erb'

#class TestSinata < Sinatra::Base

  get '/status' do
    "You've hit Sinatra at #{Time.new.utc}"
  end

#end
