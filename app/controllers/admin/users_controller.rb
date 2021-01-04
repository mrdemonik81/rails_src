# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    def index
      authorize_action
      render :index, locals: { users: scope.active.paginate(page: params[:page]) }
    end

    def edit
      authorize_action(user)
      render :edit, locals: { user: user }
    end

    def update
      authorize_action(user)
      if user.update(user_params)
        redirect_to admin_users_path,
                    notice: "User account #{helpers.link_to(user.full_name, edit_admin_user_path(user))} was updated"
      else
        render :edit, locals: { user: user }, status: :unprocessable_entity
      end
    end

    private

    def user
      @user ||= scope.find(params[:id])
    end

    def authorize_action(record = User)
      authorize record, "#{action_name}?", policy_class: policy_class
    end

    def policy_class
      Admin::UserPolicy
    end

    def scope
      policy_scope(User, policy_scope_class: Admin::UserPolicy::Scope)
    end

    def user_params
      params.require(:user).permit(:email, :fname, :lname, :mobile, :locale, :role, :status, :about)
    end
  end
end
