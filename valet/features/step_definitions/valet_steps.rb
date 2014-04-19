When(/^I park my car in the ([\w -]+ Parking) Lot for (.*)$/) do |parking_lot, duration|
  $parkcalc.select parking_lot
  $parkcalc.thirty_minutes
end

Then(/^I will have to pay (.*)$/) do |price|
  @actual_price = $parkcalc.calculate_price
  @expected_price = price.split('$')[1].strip

  @actual_price.should eq(@expected_price),
    "Expected price of #{@expected_price}, instead got price of #{@actual_price}"
end
