# frozen_string_literal: true

Given('I am on homepage') do
  visit '/'
end

Then('I should see welcome message') do
  expect(page).to have_content('Welcome to Edun')
end
