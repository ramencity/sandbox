require 'erb'
require 'json'
require 'sinatra'
require 'tilt/erb'

SINATRA_LOG = File.join(ENV['HOME'], 'sinatra.log')

class MockPoster < Sinatra::Base

  configure do
    File.delete(SINATRA_LOG) if File.exist?(SINATRA_LOG)
    file = File.new(SINATRA_LOG, 'w+')
    file.sync = true
    use Rack::CommonLogger, file
  end

  # sanity-check that Sinatra started up:
  get '/hey' do
    'I live...'
  end

  post '/post01' do
    request.body.rewind
    @posts = JSON.parse(request.body.read)
    erb :posts
  end

end
