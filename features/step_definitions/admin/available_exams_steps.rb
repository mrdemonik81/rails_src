# frozen_string_literal: true

Given(/^these exams:$/) do |table|
  @exams = {}
  table.hashes.each do |exam_attributes|
    exam = create(:exam, exam_attributes)
    @exams[exam_attributes['name']] = exam
  end
end
