# frozen_string_literal: true

When('I click bulk assign button on {string} exam') do |exam_name|
  click_link(href: /#{bulk_assign_admin_exam_path(@exams[exam_name])}$/)
end

Then('I should see bulk assign form for {string} exam') do |exam_name|
  expect(page).to have_css('#bulk_assign_form', visible: true)
  form_elem = page.find('#bulk_assign_form', visible: true)
  expect(form_elem).to have_text(exam_name)
end

When('I paste the following candidate data to bulk assign form:') do |table|
  excel_data = table.raw.map { |row| row.join("\t") }.join("\n")
  within '#bulk_assign_form' do
    candidates_elem = find('#bulk_assign_candidates')
    execute_script('arguments[0].value = arguments[1]', candidates_elem, excel_data)
  end
end

When('I enter the following data to bulk assign form and submit:') do |table|
  attributes = table.hashes.first
  within '#bulk_assign_form' do
    select attributes[:client], from: 'bulk_assign_client_id'
    expires_at_elem = find('#bulk_assign_expires_at')
    execute_script('arguments[0].value = arguments[1]', expires_at_elem, attributes[:expires_at])
    click_button 'commit'
  end
end

Then('I should be on {string} admin client examinations page with success message') do |client_name|
  expect(page).to have_current_path(admin_client_examinations_path(@clients[client_name]))
  expect(page).to have_css('.alert-success', visible: true)
end
