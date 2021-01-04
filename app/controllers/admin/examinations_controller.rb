# frozen_string_literal: true

module Admin
  class ExaminationsController < AdminController
    before_action :authorize_action
    layout :resolve_layout

    def resolve_layout
      case action_name
      when 'index'
        'admin/wide'
      else
        'examiner/clean'
      end
    end

    def index
      search_form = scope.ransack(params[:q])
      examinations = search_form.result(distinct: true)
      render :index, locals: { examinations: examinations.kept.paginate(page: params[:page]), search_form: search_form }
    end

    def show
      authorize_action(examination)
      examiners = User.active_options_for_select(User.where(role: %w[examiner admin]))
      render :show, locals: { examination: examination, examiners: examiners }
    end

    def edit
      authorize_action(examination)
      render :edit, locals: { examination: examination }
    end

    def new
      examination = Examination.new
      render :new, locals: { examination: examination }
    end

    def create
      examination = Examination.create(examination_params)
      respond_to do |format|
        if examination.save
          format.html do
            redirect_to admin_client_examinations_path(examination.client), notice: 'Examination was successfully created.'
          end
        else
          format.html { render :new, locals: { examination: examination }, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize_action(examination)
      if examination.update(examination_params)
        redirect_to admin_examination_path(examination), notice: t('.examination_updated_html')
      else
        render :show, locals: { examination: examination }, status: :unprocessable_entity
      end
    end

    def destroy
      authorize_action(examination)
      examination.discard
      respond_to do |format|
        format.html { redirect_to admin_examinations_path, notice: 'The examination was successfully removed.' }
      end
    end

    private

    def examination
      @examination ||= scope.find(params[:id])
    end

    def authorize_action(record = Examination)
      authorize record, "#{action_name}?", policy_class: policy_class
    end

    def policy_class
      Admin::ExaminationPolicy
    end

    def scope
      policy_scope(Examination, policy_scope_class: Admin::ExaminationPolicy::Scope)
    end

    def examination_params
      params.require(:examination).permit(:client_candidate_id, :exam_id, :expires_at, :comment, :user_id)
    end
  end
end
