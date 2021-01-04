# frozen_string_literal: true

Given('initial skills:') do |table|
  @skills = Skill.create(table.hashes)
end

Given('initial domains:') do |table|
  @domains = Domain.create(table.hashes)
end

When(/^I submit audio dialogue item form with audio file "([^"]*)" attached$/) do |audio|
  within 'form.new_task_item' do
    attach_file 'task_item_audio',
                Rails.root.join('spec', 'fixtures', 'files', audio),
                visible: false
    click_button 'Save changes'
  end
end

And(/^we have the following audio items:$/) do |table|
  table.hashes.each do |attr|
    item = @task.items.new
    item.audio.attach(io: File.open(audio_fixture_file), filename: attr[:audio_file])
    item.save
  end
end

def audio_fixture_file
  Rails.root.join('spec', 'fixtures', 'files', 'audio.mp3')
end

When(/^I move "([^"]*)" item up$/) do |item|
  within('div.card', text: item) do
    click_link 'Move up'
  end
end

Then(/^item "([^"]*)" becomes the first$/) do |item|
  within '#task_items' do
    within 'div.card', match: :first do
      expect(page).to have_content(item)
    end
  end
end
