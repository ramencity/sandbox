require 'watir-webdriver'
require 'rspec/expectations'
require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'parkcalc')

browser = Watir::Browser.new
$parkcalc = ParkCalcPage.new(browser)


at_exit do
  @browser.close
end
