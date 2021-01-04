# frozen_string_literal: true

Given('initial skills:') do |table|
  @skills = Skill.create(table.hashes)
end

Given('initial domains:') do |table|
  @domains = Domain.create(table.hashes)
end

When(/^I fill in fill in blanks task item form with "([^"]*)"$/) do |question|
  within 'form.new_task_item' do
    fill_in 'task_item_question', with: question
    click_button 'save'
  end
end
