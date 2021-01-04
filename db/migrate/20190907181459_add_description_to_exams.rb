class AddDescriptionToExams < ActiveRecord::Migration[6.0]
  def change
    add_column :exams, :description, :text
  end
end
