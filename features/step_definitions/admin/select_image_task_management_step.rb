# frozen_string_literal: true

When(/^I submit select image task item form with "([^"]*)"$/) do |question|
  within 'form.new_task_item' do
    fill_in 'task_item_question', with: question
    click_button 'Add question'
  end
end

Given(/^I have added selected image task item "([^"]*)"$/) do |item|
  step 'as author I am on the edit admin task page'
  step "I submit select image task item form with \"#{item}\""
  step "I should see \"#{item}\" on the page"
end

When(/^I submit image option form with "([^"]*)" image attached$/) do |image|
  within 'form.new_item_option' do
    attach_file 'item_option_image',
                Rails.root.join('spec', 'fixtures', 'files', image), visible: false
    click_button 'Save'
  end
end

Then(/^I should see the image "(.+)"$/) do |image|
  expect(page).to have_content(image)
end
