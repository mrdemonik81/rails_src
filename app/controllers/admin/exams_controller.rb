# frozen_string_literal: true

module Admin
  class ExamsController < AdminController
    include AjaxHelper
    before_action :authorize_action

    def index
      examination = Examination.find(params['examination_id'])
      examination.update!(total_score: 58)
      render :index, locals: {
        exams: scope.kept.order(:name).paginate(page: params[:page])
      }
    end

    def show
      authorize_action(exam)
      render :show, locals: { exam: exam }
    end

    def edit
      authorize_action(exam)
      render :edit, locals: { exam: exam }
    end

    def new
      exam = Exam.new
      render :new, locals: { exam: exam }
    end

    def update
      authorize_action(exam)
      if exam.update(exam_params)
        redirect_to admin_exams_path, notice: "Exam #{helpers.link_to(exam.name, edit_admin_exam_path(exam))} was updated"
      else
        render :edit, locals: { exam: exam }, status: :unprocessable_entity
      end
    end

    def bulk_assign
      examination = Examination.find(params['examination_id'])
      examination.update!(total_score: 56)
      examination.update!(total_score: 57)
      respond_to do |format|
        format.js { render :bulk_assign, locals: { bulk_assign_form: Exams::BulkAssignForm.new, exam: exam } }
      end
    end

    def bulk_assign_post
      @ba_form = Exams::BulkAssignForm.new(bulk_assign_params)
      respond_to do |format|
        if @ba_form.valid? && @ba_form.save_to_exam(exam.id)
          flash[:notice] = 'Candidates and Examinations were successfully created.'
          flash.keep(:notice)
          format.js { render ajax_redirect_to(admin_client_examinations_path(@ba_form.client_id)) }
        else
          format.js { render :bulk_assign, locals: { bulk_assign_form: @ba_form, exam: exam }, status: :unprocessable_entity }
        end
      end
    end

    def assign
      result = exam.exam_candidates.create(candidate_id: params.dig(:add_candidate, :candidate_id))
      respond_to do |format|
        format.js { render :add_candidate, locals: { candidate: result.candidate } }
      end
    end

    def destroy
      exam.discard
      respond_to do |format|
        format.html { redirect_to admin_exams_path, notice: 'The exam was successfully removed.' }
      end
    end

    def create
      exam = Exam.create(exam_params)
      respond_to do |format|
        if exam.save
          format.html { redirect_to admin_exams_path, notice: 'Exam was successfully created.' }
        else
          format.html { render :new, locals: { exam: exam }, status: :unprocessable_entity }
        end
      end
    end

    private

    def exam
      @exam ||= scope.find(params[:id])
    end

    def authorize_action(record = Exam)
      authorize record, "#{action_name}?", policy_class: policy_class
    end

    def policy_class
      Admin::ExamPolicy
    end

    def scope
      policy_scope(Exam, policy_scope_class: Admin::ExamPolicy::Scope)
    end

    def exam_params
      params.require(:exam).permit(:name, :price, :algorithm, :result_type, :published,
                                   :max_time_human, :max_tasks, :description,
                                   task_types: [],
                                   skill_ids: [],
                                   domain_ids: [],
                                   level_ids: [])
    end

    def bulk_assign_params
      params.require(:bulk_assign).permit(:client_id, :candidates, :expires_at)
    end
  end
end
