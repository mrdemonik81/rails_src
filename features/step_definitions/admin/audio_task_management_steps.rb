# frozen_string_literal: true

Given('initial skills:') do |table|
  @skills = Skill.create(table.hashes)
end

Given('initial domains:') do |table|
  @domains = Domain.create(table.hashes)
end

When(/^I submit minimum duration form with "([^"]*)"$/) do |minimum_duration|
  within 'form.edit_task_item' do
    fill_in 'task_item_minimum_duration', with: minimum_duration
    click_button 'Save changes'
  end
end
