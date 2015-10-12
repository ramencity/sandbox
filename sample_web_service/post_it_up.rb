require 'json'
require 'net/http'
require './mock_poster.rb'

SINATRA_HOST = '127.0.0.1'
SINATRA_PORT = '4567'

def start_mock_poster
  Thread.new do
    MockPoster.run! host: SINATRA_HOST, port: SINATRA_PORT
  end
end

begin
  # start Sinatra
  start_mock_poster

  # send Sinatra some JSON...
  post_body = File.read('./some_posts.json')
  post_me = Net::HTTP::Post.new('/post01')
  post_me.body = post_body
  client = Net::HTTP.start(SINATRA_HOST, SINATRA_PORT)

  #...get some HTML back:
  response = client.request(post_me)
  puts "\n\nResponse body from Sinatra is:\n#{response.body}\n\n"
end
