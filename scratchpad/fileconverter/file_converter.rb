require 'json'
require 'zlib'
require 'base64'
require 'stringio'

puts "Give me a file name you want to convert that's in the directory you\'re in"
rawfile = gets.chomp

while File.exist?(".//" + rawfile) == false
  puts "that is not a valid file name!  Try again"
  rawfile = gets.chomp
end

readme = File.read(File.open(".//" + rawfile))

puts "do you want to encode or decode the file?"
action = gets.chomp.downcase

until action == 'encode' || action == 'decode'
  puts "that is not an option!  Enter encode or decode"
  action = gets.chomp.downcase
end

if action == 'encode'
  #gzip the file:
  zipup = StringIO.new("w")
  gzip = Zlib::GzipWriter.new(zipup)
  gzip.write(readme)
  gzip.close
  zipped = zipup.string

  #then base64 encode the puppy:
  encoded = Base64.encode64(zipped).force_encoding('UTF-8')
  File.open(".//" + rawfile + "_encoded.gz", "w") {|file| file.puts encoded}

  puts "Your new file is called " + rawfile + "_encoded.gz"

elsif action == 'decode'
  #first we base64 decode the puppy:
  decoded = Base64.decode64(readme)

  #then we g-unzip the file:
  unzip = Zlib::GzipReader.new(StringIO.new(decoded))
  File.open(".//" + rawfile + "_decoded.json", "w") {|file| file.puts unzip.read}

  puts "Your new file is called " + rawfile + "_decoded.json"
end
