When(/^I park my car in the Valet Parking Lot for (.*)$/) do |duration|
  $parkcalc.thirty_minutes
end

Then(/^I will have to pay (.*)$/) do |price|
  @actual_price = $parkcalc.calculate_price

  @price = price.split('$')[1].strip
  @actual_price.should eq(@price),
    "Expected price of #{@price}, instead got price of #{@actual_price}"
end
