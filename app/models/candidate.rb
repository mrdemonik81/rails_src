# frozen_string_literal: true

# == Schema Information
#
# Table name: candidates
#
#  id           :bigint           not null, primary key
#  fname        :string
#  lname        :string
#  email        :string
#  mobile       :string
#  locale       :string
#  discarded_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  gender       :integer          default("unknown"), not null
#  ssn          :string           default(""), not null
#

class Candidate < ApplicationRecord
  include Discard::Model
  include PgSearch::Model

  has_many :examinations, through: :client_candidates
  has_many :client_candidates, dependent: :destroy
  has_many :clients, through: :client_candidates

  validates :email,
            uniqueness: {
              case_sensitive: false
            },
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :fname, presence: true
  validates :lname, presence: true
  validate :correct_ssn_format

  enum gender: { unknown: 0, male: 1, female: 2 }

  pg_search_scope :search,
                  against: %i[fname lname email],
                  using: {
                    tsearch: {
                      prefix: true, normalization: 2, any_word: true
                    }
                  }

  def full_name
    "#{fname.titleize} #{lname.titleize}"
  end

  after_discard do
    client_candidates.discard_all
  end

  after_undiscard do
    client_candidates.undiscard_all
  end

  private

  def correct_ssn_format
    self.ssn = ssn.to_s.gsub(/[^\d]+/, '') if ssn.present?
    errors.add(:ssn, 'wrong format for social security number') if ssn.to_s !~ /\A([\d]{10,11}|[\d]{5,6}|^$)\z/i
  end
end
