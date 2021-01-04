# frozen_string_literal: true

json.items candidates do |candidate|
  json.extract! candidate, :id
  json.text "#{candidate.full_name} <#{candidate.email}>"
end
