Given(/^(\d+) and (\d+)$/) do |input_a, input_b|
  @input_a = input_a
  @input_b = input_b
end

When(/^they are numbers$/) do
  #stuff...
end

Then(/^we add them$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the result matches my (\d+)$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
