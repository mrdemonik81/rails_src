# frozen_string_literal: true

Given(/^I am on (?:the )?new admin exam page$/) do
  visit '/admin/exams/new'
end

When(/^I submit new exam form with the following data:$/) do |_table|
  # table is a table.hashes.keys # => [:name, :price, :algorithm, :result_type, :max_time, :max_tasks, :published]
  pending
end
