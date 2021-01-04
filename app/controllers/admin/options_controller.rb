# frozen_string_literal: true

class Admin::OptionsController < ApplicationController
  def create
    if form.valid? && (option = item.options.create(form.attributes))
      respond_to do |f|
        f.html { redirect_to edit_admin_task_path(item.task_id) }
        f.js { render :create, locals: { item: item, option: option } }
      end
    else
      head :unprocessable_entity
    end
  end

  def destroy
    option.destroy!
    respond_to do |f|
      f.js { render :destroy, locals: { option: option } }
    end
  end

  def toggle_correct
    @task.toggle!(:correct)
  end

  private

  def form
    option_form.new(option_params)
  end

  def item
    @item ||= TaskItem.find(params[:item_id])
  end

  def option
    @option ||= item.options.find(params[:id])
  end

  def option_form
    item.options.form
  end

  def option_params
    params.require(:item_option).permit(*option_form.params_schema)
  end
end
