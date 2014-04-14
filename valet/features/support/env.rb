require 'Watir-webdriver'
require 'rspec/expectations'
#require File.join(File.dirname(__FILE__), 'lib', 'parkcalc')

Before do
  @browser = Watir::Browser.new
  #@browser.driver.manage.window.maximize
  @browser.goto 'http://www.shino.de/parkcalc'
  #$parkcalc = ParkCalcPage.new(browser)
end

at_exit do
  #@browser.cookies.clear
  @browser.close
end
