# frozen_string_literal: true

When(/^I submit arrange words form with "([^"]*)" and "([^"]*)"$/) do |arrange_words, additional_words|
  within 'form.edit_task_item' do
    fill_in 'task_item_arrange_words', with: arrange_words
    fill_in 'task_item_additional_words', with: additional_words
    click_button 'Save changes'
  end
end
