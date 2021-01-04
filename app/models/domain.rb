# frozen_string_literal: true

# == Schema Information
#
# Table name: domains
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Domain < ApplicationRecord
  has_and_belongs_to_many :tasks, dependent: :destroy
  has_many :exam_domains, dependent: :destroy
  has_many :domains, through: :exam_domains

  validates :name, presence: true, uniqueness: true
end
