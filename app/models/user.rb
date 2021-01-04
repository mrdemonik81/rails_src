# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  fname                  :string
#  lname                  :string
#  email                  :string
#  mobile                 :string
#  locale                 :string
#  role                   :integer          default("basic")
#  status                 :integer          default("active")
#  meta                   :jsonb            not null
#  discarded_at           :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  include Discard::Model

  has_many :client_users, dependent: :destroy
  has_many :clients, through: :client_users
  has_many :identities, dependent: :destroy
  validates :email,
            uniqueness: {
              case_sensitive: false
            },
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :fname, presence: true
  validates :lname, presence: true

  enum role: { basic: 0, author: 1, examiner: 2, admin: 3 }
  enum status: { active: 0, closed: 1 }
  store_accessor :meta, %i[about]

  def self.current
    RequestStore.store[:current_user]
  end

  def self.current=(val)
    RequestStore.store[:current_user] = val
  end

  def self.active_options_for_select(scope = User.all)
    scope.active.select(:id, :fname, :lname, :email).map { |u| [u.full_name, u.id] }
  end

  def full_name
    "#{fname.titleize} #{lname.titleize}"
  end

  after_discard do
    client_users.discard_all
  end

  after_undiscard do
    client_users.undiscard_all
  end
end
