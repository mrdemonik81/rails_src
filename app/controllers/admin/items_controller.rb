# frozen_string_literal: true

class Admin::ItemsController < ApplicationController
  before_action :find_task
  before_action :find_item, only: %i[edit update destroy move_up move_down]
  before_action :authorize_action

  def create
    form = item_form.new(item_params)
    if form.valid? && (item = @task.items.create(form.attributes))
      respond_to do |f|
        f.html { redirect_to edit_admin_task_path(@task) }
        f.js { render :create, locals: { task: @task, item: item } }
      end
    else
      head :unprocessable_entity
    end
  end

  def edit; end

  def update
    form = item_form.new(item_params)
    redirect_to edit_admin_task_path(@task) if form.valid? && @item.update(form.attributes)
  end

  def destroy
    @item.destroy
    respond_to do |f|
      f.js { render :destroy, locals: { item: @item } }
    end
  end

  def move_up
    @item.move_higher
    render :reorder_items, locals: { task: @task }
  end

  def move_down
    @item.move_lower
    render :reorder_items, locals: { task: @task }
  end

  private

  def authorize_action(record = TaskItem)
    authorize record, "#{action_name}?", policy_class: policy_class
  end

  def policy_class
    Admin::ItemPolicy
  end

  def scope
    policy_scope(TaskItem, policy_scope_class: Admin::ItemPolicy::Scope)
  end

  def find_task
    @task = Task.find(params[:task_id])
  end

  def find_item
    @item = @task.items.find(params[:id])
  end

  def item_form
    @task.items.form
  end

  def item_params
    params.require(:task_item).permit(
      *item_form.params_schema
    )
  end
end
