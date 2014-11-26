require 'watir-webdriver'
require 'rspec/expectations'

BD_URL  = 'https://bdonline.sqe.com'
BD_USER = 'trogdor'
BD_PASS = 'monsoon503'

$browser = Watir::Browser.new :firefox

at_exit do
  $browser.close
end
