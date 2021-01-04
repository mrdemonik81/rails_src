# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ExamsController, type: :controller do
  before do
    allow(Exam).to receive(:find).with('1').and_return(exam)
    sign_in(current_user)
    allow(Admin::ExamPolicy::Scope).to receive(:new).and_return(scope)
    allow(scope).to receive(:resolve).and_return(Exam)
  end

  let(:current_user) { create(:user, :with_admin_role) }
  let(:scope) { instance_double(Admin::ExamPolicy::Scope) }
  let(:exam) { OpenStruct.new(id: 1) }

  describe 'GET :id/#bulk_assign' do
    before { get :bulk_assign, params: { id: exam.id }, xhr: true }

    it { is_expected.to respond_with(200) }
    it { is_expected.to render_template(:bulk_assign) }
  end

  describe 'POST :id/#bulk_assign' do
    let(:valid_params) do
      {
        client_id: 1,
        candidates: "some header\nsome rows",
        expires_at: '2019-09-14'
      }
    end
    let(:invalid_params) { valid_params.merge(candidates: nil) }

    context 'with valid params' do
      before do
        allow(Clients::Pipelines::CreateCandidatesAndExaminationsFromText).to receive(:call).and_return(success_result)
        post :bulk_assign_post, params: { id: exam.id, bulk_assign: valid_params }, xhr: true
      end

      let(:success_result) { OpenStruct.new(success?: true) }

      it { is_expected.to respond_with(200) }
    end

    context 'with invalid params' do
      before do
        post :bulk_assign_post, params: { id: exam.id, bulk_assign: invalid_params }, xhr: true
      end

      it { is_expected.to respond_with(422) }
      it { is_expected.to render_template(:bulk_assign) }
    end
  end
end
