require 'json'
require 'zlib'
require 'base64'
require 'stringio'
require 'stomp'

begin
  puts 'What is the name of the queue you want to write to?'
  queue = gets.chomp.strip
  @queue_name = "/queue/" + queue

  puts 'What file in your current directory do you want to send to the queue?'
  rawfile = gets.chomp.strip
  while File.exist?(".//" + rawfile) == false
    puts "I don't see that file in here! Try again"
    rawfile = gets.chomp.strip
  end

  puts 'Do you want your message zipped up and base-64 encoded? Answer yes or no'
  message_encoded = gets.chomp.strip.downcase
  until message_encoded == 'yes' || message_encoded == 'no'
    puts "that is not an option! Enter yes or no"
    message_encoded = gets.chomp.strip.downcase
  end

  if message_encoded == 'yes'
    readfile = File.read(rawfile)
    zipup = StringIO.new("w")
    gzip = Zlib::GzipWriter.new(zipup)
    gzip.write(readfile)
    gzip.close
    zipstring = zipup.string
    message = Base64.encode64(zipstring).force_encoding('UTF-8')
  else
    message = File.read(rawfile)
  end

    puts 'Ok, attempting to connect to queue ' + queue
  client = Stomp::Client.new('admin', 'password', "backend.mss.monsoonqa.com", 61613)
    puts 'Sending message'
  client.publish(@queue_name, "#{message}", {:persistent => true})
    puts "(#{Time.now}) Message sent - cheers!"
   
end
