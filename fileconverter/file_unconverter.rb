require 'json'
require 'zlib'
require 'base64'
require 'stringio'

puts "Give me a file name you want to unconvert that's in the directory you\'re in"
rawfile = gets.chomp
readme = File.open(".//" + rawfile)
readit = File.read(readme)

#first we base64 decode the puppy:
decoded = Base64.decode64(readit)

#then we g-unzip the file:
unzip = Zlib::GzipReader.new(StringIO.new(decoded))
File.open(".//" + rawfile + "_decoded.json", "w") {|file| file.puts unzip.read}

puts "Your new file is called " + rawfile + "_decoded.json"
