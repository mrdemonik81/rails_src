# frozen_string_literal: true

module Admin
  class TasksController < AdminController
    before_action :find_task, only: %i[edit update settings update_settings toggle_published]
    before_action :authorize_action
    layout :resolve_layout

    def resolve_layout
      case action_name
      when 'index'
        'admin/wide'
      else
        'authoring/clean'
      end
    end

    def index
      search_form = scope.ransack(params[:q])
      tasks = search_form.result(distinct: true)
      render :index, locals: { tasks: tasks.paginate(page: params[:page]), search_form: search_form }
    end

    def new
      render :new, locals: { task_form: Tasks::CreateForm.new }
    end

    def create
      @task_form = Tasks::CreateForm.new(task_params)
      if @task_form.valid? && (task = Task.create(@task_form.attributes))
        redirect_to edit_admin_task_path(task)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def settings
      render :settings, locals: { task_form: Tasks::UpdateForm.new(task: @task) }
    end

    def update_settings
      task_form = Tasks::UpdateForm.new(task_params)
      if task_form.valid? && @task.update(task_form.attributes)
        redirect_to settings_admin_task_path(@task), notice: 'Task was updated'
      else
        render :edit, locals: { task: @task, task_form: task_form }
      end
    end

    def edit
      task_form = update_form.new(task: @task)

      render :edit, locals: { task: @task, task_form: task_form }
    end

    def update
      task_form = update_form.new(update_task_params)
      if task_form.valid? && @task.update(task_form.attributes)
        redirect_to edit_admin_task_path(@task)
      else
        render :edit, locals: { task: @task, task_form: task_form }
      end
    end

    def toggle_published
      @task.toggle!(:published)
    end

    private

    def authorize_action(record = Task)
      authorize record, "#{action_name}?", policy_class: policy_class
    end

    def policy_class
      Admin::TaskPolicy
    end

    def scope
      policy_scope(Task, policy_scope_class: Admin::TaskPolicy::Scope)
    end

    def find_task
      @task = Task.find(params[:id])
    end

    def update_form
      @task.class.const_get(:Form)
    end

    def update_task_params
      params
        .require(:task)
        .permit(*update_form.params_schema)
    end

    def filter_params
      params.permit(:status, :type, :published)
    end

    def task_params
      params.require(:task).permit(
        :name, :complexity, :performance, :type, :published, :score_method,
        skill_ids: [],
        domain_ids: [],
        level_ids: []
      )
    end
  end
end
