# frozen_string_literal: true

class TaskItemOptions::SelectImage::Form < TaskItemOptions::BasicForm
  attribute :option, TaskItemOptions::SelectImage
  attribute :correct, Axiom::Types::Boolean, default: false
  attribute :image, ActiveStorage::Attached::One
  validates :image,
            file_size: {
              less_than_or_equal_to: 10.megabytes,
              message: 'images should be less than %{count}'
            },
            file_content_type: {
              allow: %w[image/png image/jpeg images/jpg images/gift]
            }

  def self.params_schema
    %i[correct image]
  end
end
