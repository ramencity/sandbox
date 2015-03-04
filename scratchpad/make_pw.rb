require 'optparse'

#Command-line options:
options = {}

optparse = OptionParser.new do |opts|
#banner at top of HELP screen:
  opts.banner = 'create a password of N length.  Password will have at least one each of uppercase, lowercase, numeral and symbol.'

  options[:length]
  opts.on('-l LENGTH', '--length LENGTH', 'REQUIRED: requested password length (some number)') do |length|
    options[:length] = length
  end

  opts.on('-h', '--help', 'Display this screen') do
    puts opts
    exit
  end
end

# Parse the command-line:
optparse.parse!

@pw_length = options[:length].to_i

class PasswordMaker

  attr_accessor :password

  def initialize(pw_length)
    @pw_length = pw_length
    @password = password
  end

  def upcased
    @upcased = ('A'..'Z')
  end

  def downcased
    @downcased = ('a'..'z')
  end

  def numbers
    @numbers = ('0'..'9')
  end

  def chars
    @chars = %w(* ! # _ $ % &)
  end

  def charset
    @charset = [upcased, downcased, numbers, chars].map { |i| i.to_a }.flatten
  end

  def password_regex
    @password_regex = /(?=.*[#{numbers}])(?=.*[#{downcased}])(?=.*[#{upcased}])(?=.*[#{chars}])/
  end

  def make_password
    @password = ((0..(@pw_length-1)).map { charset[rand(charset.length)] }.join) #@pw_length -1 because 0-based index
  end

  def validate_password
    @password.match(password_regex) ? @password : make_password
  end

end #class

pw = PasswordMaker.new(@pw_length)
pw.make_password
pw.validate_password

puts pw.password
