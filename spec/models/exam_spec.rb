# frozen_string_literal: true

# == Schema Information
#
# Table name: exams
#
#  id           :bigint           not null, primary key
#  name         :string
#  published    :boolean          default(FALSE)
#  max_time     :integer
#  max_tasks    :integer
#  price        :decimal(6, 2)
#  algorithm    :integer          default("random")
#  result_type  :integer          default("minimal")
#  task_types   :text             default([]), is an Array
#  discarded_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  description  :text
#

require 'rails_helper'

RSpec.describe Exam, type: :model do
  describe 'Table structure' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:published).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:max_time).of_type(:integer) }
    it { is_expected.to have_db_column(:max_tasks).of_type(:integer) }
    it { is_expected.to have_db_column(:price).of_type(:decimal).with_options(precision: 6, scale: 2) }
    it { is_expected.to have_db_column(:algorithm).of_type(:integer).with_options(default: :random) }
    it { is_expected.to have_db_column(:result_type).of_type(:integer).with_options(default: :minimal) }
    it { is_expected.to have_db_column(:task_types).of_type(:text).with_options(array: true, default: []) }
  end

  describe 'Table indexes' do
    it { is_expected.to have_db_index(:discarded_at) }
  end

  describe 'Model validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:max_time) }
    it { is_expected.to validate_presence_of(:max_tasks) }
    it { is_expected.to define_enum_for(:algorithm).with_values(described_class.algorithms.keys) }
    it { is_expected.to define_enum_for(:result_type).with_values(described_class.result_types.keys) }
    it { is_expected.to validate_numericality_of(:max_time).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:max_tasks).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0).allow_nil }
  end

  describe 'Model relations' do
    # it { is_expected.to have_many(:attachments_attachments) }
    it { is_expected.to have_one(:image_attachment) }
    it { is_expected.to have_many(:examinations) }
  end
end
