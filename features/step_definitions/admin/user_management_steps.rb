# frozen_string_literal: true

Given(/^as (user|examiner|author|admin) I am on(?: the)? (.*) page/) do |role, path|
  steps %(
    Given I am #{role}
    And I am on #{path} page
  )
end

Given(/^I am(?: (?:an?|the))? (user|examiner|author|admin)/) do |role|
  role = 'basic' if role == 'user'
  @current_user = create(:user, :with_google_identity, role: role, status: :active)
  @identity = @current_user.identities.first
  mock_oauth(@identity)
  visit "/users/auth/#{@identity.provider}"
end

Given(/^(?:there are )?(\d+)(?: more)?(?: (active|closed))? users/) do |count, status|
  status ||= 'pending'
  create_list(:user, count, status: status)
end

Given('these users:') do |table|
  @users = {}
  table.hashes.each do |user_attributes|
    user = create(:user, user_attributes)
    @users[user_attributes['fname']] = user unless user.closed?
  end
end

When(/^I am on(?: the)? (?:(\w+)'s) edit admin user page/) do |user|
  visit edit_admin_user_path(@users[user])
end

When(/^I am on(?: the)? (admin .*) page/) do |path|
  visit path_to(path)
end

When(/^I am on(?: the)? (workspace .*) page/) do |path|
  visit path_to(path)
end

Then('I can edit my own profile') do
  within('tr', text: @current_user.email) do
    expect(page).to have_link('Edit')
  end
end

Then('I can edit all users') do
  @users.values.each do |user|
    within('tr', text: user.email) do
      expect(page).to have_link('Edit')
    end
  end
end

Then('I cannot edit profiles') do
  @users.values.uniq.each do |user|
    within('tr', text: user.email) do
      expect(page).not_to have_link('Edit')
    end
  end
end

When(/^I change (?:(\w+)'s) role to (.*)$/) do |name, role|
  within('#roles_form') do
    choose "user_role_#{role}", allow_label_click: true
    expect do
      click_button 'Save changes'
    end.to change {
      User.find(@users[name].id).role
    }.from(@users[name].role).to(role)
  end
end

When("I toggle a user's status") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('it becomes active') do
  pending # Write code here that turns the phrase above into concrete actions
end
