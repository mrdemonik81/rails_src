# frozen_string_literal: true

module BaseType
  extend ActiveSupport::Concern

  class_methods do
    delegate :model_name, to: :superclass
  end
end
