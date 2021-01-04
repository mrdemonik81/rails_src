# frozen_string_literal: true

module Admin
  class CandidatesController < AdminController
    def index
      authorize_action
      respond_to do |f|
        f.html { render :index, locals: { candidates: scope.paginate(page: params[:page]) } }
        f.json { render :index, locals: { candidates: scope.search(params[:q]).paginate(page: params[:page]) } }
      end
    end

    def create
      authorize_action
      candidate = Candidate.create(candidate_params)
      respond_to do |format|
        if candidate.save
          format.html { redirect_to edit_admin_candidate_path(candidate.id), notice: 'Candidate was successfully created.' }
        else
          format.html { render :new, locals: { candidate: candidate }, alert: 'Error...' }
        end
      end
    end

    def new
      authorize_action
      candidate = Candidate.new
      render :new, locals: { candidate: candidate }
    end

    def edit
      authorize_action(candidate)
      render :edit, locals: { candidate: candidate }
    end

    def update
      authorize_action(candidate)
      if candidate.update(candidate_params)
        redirect_to edit_admin_candidate_path, notice: 'The candidate was updated successfully.'
      else
        render :edit, locals: { candidate: candidate }, status: :unprocessable_entity
      end
    end

    def destroy
      authorize_action
      candidate.discard
      respond_to do |format|
        format.html { redirect_to admin_candidates_path, notice: 'The candidate was successfully destroyed.' }
      end
    end

    private

    def candidate
      @candidate ||= scope.find(params[:id])
    end

    def authorize_action(record = Candidate)
      authorize record, "#{action_name}?", policy_class: policy_class
    end

    def policy_class
      Admin::CandidatePolicy
    end

    def scope
      policy_scope(Candidate, policy_scope_class: Admin::CandidatePolicy::Scope)
    end

    def candidate_params
      params.require(:candidate).permit(:email, :fname, :lname, :mobile, :locale, :gender, :ssn)
    end
  end
end
