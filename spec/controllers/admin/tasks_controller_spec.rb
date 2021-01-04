# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::TasksController, type: :controller do
  before do
    allow(Tasks::CreateForm).to receive(:new).and_return(task_form)
    allow(Task).to receive(:create).and_return(task)
    allow(Task).to receive(:find).with('1').and_return(task)
    sign_in(current_user)
    allow(Admin::TaskPolicy::Scope).to receive(:new).and_return(scope)
    allow(scope).to receive(:resolve).and_return(Task)
  end

  let(:current_user) { create(:user, :with_admin_role) }
  let(:scope) { instance_double(Admin::TaskPolicy::Scope) }
  let(:valid_params) do
    {
      name: 'Task',
      type: Task.types.first,
      complexity: Task.complexities.keys.first,
      performance: 0.5
    }
  end
  let(:invalid_params) { valid_params.merge(name: nil) }
  let(:task_form) { instance_double(Tasks::CreateForm) }
  let(:task) { OpenStruct.new(id: 1) }

  describe 'GET #new' do
    before { get :new }

    it { is_expected.to respond_with(200) }
    it { is_expected.to render_template(:new) }
  end

  describe 'POST #create' do
    context 'with valid params' do
      before do
        allow(task_form).to receive(:valid?).and_return(true)
        allow(task_form).to receive(:attributes)
        post :create, params: { task: valid_params }
      end

      it { is_expected.to respond_with(302) }
    end

    context 'with invalid params' do
      before do
        allow(task_form).to receive(:valid?).and_return(false)
        allow(task_form).to receive(:attributes)
        post :create, params: { task: invalid_params }
      end

      it { is_expected.to respond_with(422) }
      it { is_expected.to render_template(:new) }
    end
  end
end
