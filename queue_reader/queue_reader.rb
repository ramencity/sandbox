require 'json'
require 'zlib'
require 'base64'
require 'stringio'
require 'stomp'

begin
  puts 'What is the name of the queue you want to read from?'
  queue = gets.chomp
  @queue_name = "/queue/" + queue

  puts 'Is your message zipped up and base-64 encoded?  Answer yes or no'
  message_type = gets.chomp.downcase

  until message_type == 'yes' || message_type == 'no'
    puts "that is not an option! Enter yes or no"
    message_type = gets.chomp
  end

  puts 'Ok, attempting to connect to queue ' + queue

  begin
    @client = Stomp::Client.new('admin', 'password', "backend.mss.monsoonqa.com", 61613)
    Timeout::timeout(10) {
      @client.subscribe(@queue_name) do |msg|
        @msg_body = msg.body
        @client.close
      end
      @client.join
    }
    @client.close

  rescue SocketError => se
    puts "Got socket error: #{se}"
  end

  if message_type == 'yes'
    decoded = Base64.decode64(@msg_body).force_encoding('UTF-8')
    unzip = Zlib::GzipReader.new(StringIO.new(decoded))
    @json = JSON.parse(unzip.read)
  else
    @json = JSON.parse(@msg_body)
  end

  File.open(".//queue_message.json", "w") {|f| f.puts @json}
  puts 'Your file is in this directory and is called queue_message.json'
end
