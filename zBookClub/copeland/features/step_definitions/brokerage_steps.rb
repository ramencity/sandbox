Given(/^I have a browser open to the brokerage page$/) do
  $browser.goto BD_URL
end

When(/^I log in to my brokerage account$/) do
  $browser.link(:href, "https://bdonline.sqe.com/login.asp").click
  $browser.text_field(:name, 'login').set BD_USER
  $browser.text_field(:name, 'password').set BD_PASS
  $browser.button(:xpath, "//input[@alt='Login']").click
end

Then(/^I see stuff that shows I'm logged in$/) do
  unless $browser.text.include? 'Fed Reduces Rate, Creates Buying Frenzy On Wall Street'
    puts 'Hmm, this isn\'t the page you\'re looking for...'
  end
end
