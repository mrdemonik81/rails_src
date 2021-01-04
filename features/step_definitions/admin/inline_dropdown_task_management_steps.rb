# frozen_string_literal: true

Given('initial skills:') do |table|
  @skills = Skill.create(table.hashes)
end

Given('initial domains:') do |table|
  @domains = Domain.create(table.hashes)
end

When(/^I fill in inline dropdown task item form with "([^"]*)"$/) do |statement|
  within 'form.new_task_item' do
    fill_in 'task_item_statement', with: statement
    click_button 'Add block'
  end
end

Then(/^I should see "([^"]*)" on the current page$/) do |text|
  expect(page).to have_content(text)
end
