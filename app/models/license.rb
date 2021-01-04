# frozen_string_literal: true

# == Schema Information
#
# Table name: licenses
#
#  id              :bigint           not null, primary key
#  client_id       :bigint           not null
#  licensable_type :string
#  licensable_id   :bigint
#  amount          :integer          default(1), not null
#  expires_at      :date
#  discarded_at    :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class License < ApplicationRecord
  has_paper_trail
  include Discard::Model
  belongs_to :client
  belongs_to :licensable, polymorphic: true
  validates :expires_at, presence: true
  validates :amount, numericality: true
  scope :exams, (-> { where(licensable_type: 'Exam') })
  scope :active, (-> { where('licenses.expires_at >= ?', Time.zone.today) })
end
