class SwapClientCandidateRelationToExaminations < ActiveRecord::Migration[6.0]
  def change
    remove_reference :examinations, :client, foreign_key: true
    remove_reference :examinations, :candidate, foreign_key: true
    add_reference :examinations, :client_candidate, foreign_key: true
  end
end
