When(/^I park my car in the Valet Parking Lot for (.*) minutes$/) do |duration|
  @browser.text_field(:id, 'StartingDate').set '4/1/2014' #hardcode for now, fix later
  #@browser.text_field(:id, 'StartingTime').set '' #leave at 12:00 AM for now
  @browser.text_field(:id, 'LeavingDate').set '4/1/2014'
  @browser.text_field(:id, 'LeavingTime').set '12:30'
end

Then(/^I will have to pay (.*)$/) do |price|
  @browser.button(:value, 'Calculate').click
  actual_price = @browser.table[3][1].text.split()[1].strip

  @price = price.split('$')[1]
  actual_price.should eq(@price),
    "Expected price of #{@price}, instead got price of #{actual_price}"

  @browser.close
end
