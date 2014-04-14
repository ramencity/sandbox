require 'json'
require 'zlib'
require 'base64'
require 'stringio'

puts "Give me a file name you want to convert that's in the directory you\'re in"
rawfile = gets.chomp
readme = File.open(".//" + rawfile)
readit = File.read(readme)

#gzip the file:
zipup = StringIO.new("w")
gzip = Zlib::GzipWriter.new(zipup)
gzip.write(readit)
gzip.close
zipped = zipup.string

#then base64 encode the puppy:
encoded = Base64.encode64(zipped).force_encoding('UTF-8')
File.open(".//" + rawfile + "_encoded.gz", "w") {|file| file.puts encoded}

puts "Your new file is called " + rawfile + "_encoded.gz"
