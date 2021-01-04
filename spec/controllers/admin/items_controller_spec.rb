# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ItemsController, type: :controller do
  before do
    allow(Task).to receive(:create).and_return(task)
    allow(Task).to receive(:find).with('1').and_return(task)
    sign_in(current_user)
  end

  let(:current_user) { create(:user, :with_admin_role) }
  let(:task) { OpenStruct.new(id: 1, items: items) }
  let(:items) { double(:items, form: form, create: item) }
  let(:item) { instance_double('Item') }
  let(:form) { double(:item_form, new: form_instance, params_schema: []) }
  let(:form_instance) { instance_double('item_form', valid?: valid?) }
  let(:valid?) { true }
  let(:params) { { task_id: task.id } }

  describe 'POST #create' do
    before { allow(form_instance).to receive(:attributes) }

    let(:params) { super().merge(task_item: { bla: 'bla' }) }

    context 'with valid params' do
      subject(:response) { post :create, params: params }

      it { is_expected.to have_http_status(:found) }
    end

    context 'with invalid params' do
      subject(:response) { post :create, params: params }

      let(:valid?) { false }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end
