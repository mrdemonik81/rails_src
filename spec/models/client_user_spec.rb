# frozen_string_literal: true

# == Schema Information
#
# Table name: client_users
#
#  id           :bigint           not null, primary key
#  client_id    :bigint           not null
#  user_id      :bigint           not null
#  role         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#

require 'rails_helper'

RSpec.describe ClientUser, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
