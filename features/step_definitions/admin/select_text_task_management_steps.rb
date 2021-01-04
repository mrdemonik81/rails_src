# frozen_string_literal: true

Given(/^I am on (?:the )?new admin task page$/) do
  visit '/admin/tasks/new'
  expect(current_path).to eq('/admin/tasks/new')
end

When(/^I proceed task type select form with "([^"]*)"$/) do |type|
  select type, from: 'type'
  click_button 'Create'
end

Then(/^I should be on new "([^"]*)" form$/) do |type|
  expect(page).to have_content(type)
end

Given(/^the following skills:$/) do |table|
  @skills = Skill.create(table.hashes)
end

Given(/^the following domains:$/) do |table|
  @domains = Domain.create(table.hashes)
end

When(/^I submit new task form with the following data:$/) do |table|
  attributes = table.hashes.first
  within '#new_task' do
    fill_in 'Name', with: attributes[:Name]
    select attributes[:Type], from: 'Type'
    @skills.each do |skill|
      select skill.name, from: 'Select skills'
    end
    @domains.each do |domain|
      select domain.name, from: 'Select domains'
    end
    select attributes[:Complexity], from: 'Complexity'
    click_button 'Save and continue'
  end
end

Then(/^I should be on admin task items page$/) do
  expect(current_path).to eq(admin_task_items_path(Task.last))
end

Then(/^I should be on (?:the )?edit admin task page$/) do
  expect(current_path).to eq(edit_admin_task_path(Task.last))
end

Given(/^the following task:$/) do |table|
  # table is a table.hashes.keys # => [:name, :type, :complexity, :performance]
  @task = Task.create(table.hashes.first)
end

Given(/^I am on (?:the )?edit admin task page$/) do
  visit edit_admin_task_path(@task)
end

When(/^I submit select text task item form with "([^"]*)"$/) do |question|
  within 'form.new_task_item' do
    fill_in 'task_item_question', with: question
    click_button 'Add'
  end
end

Then(/^I should see "([^"]*)" on the page$/) do |text|
  expect(page).to have_content(text)
end

Given(/^I have added a "([^"]*)" select text task item$/) do |item|
  step 'as author I am on the edit admin task page'
  step "I submit select text task item form with \"#{item}\""
  step "I should see \"#{item}\" on the page"
end

When(/^I submit select text task item option form with "([^"]*)"$/) do |answer|
  within 'form.new_item_option' do
    fill_in 'item_option_answer', with: answer
    click_button 'Add answer'
  end
end
