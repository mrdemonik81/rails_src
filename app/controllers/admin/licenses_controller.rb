# frozen_string_literal: true

module Admin
  class LicensesController < AdminController
    before_action :authorize_action

    def show; end

    def edit
      authorize_action(license)
      render :edit, locals: { license: license }
    end

    def new
      client = Client.find(params[:client_id]) if params[:client_id]
      license = License.new
      render :new, locals: { license: license, client: client }
    end

    def create
      license = License.create(license_params)
      respond_to do |format|
        if license.save
          format.html do
            redirect_to admin_client_path(license.client), notice: 'License was successfully created.'
          end
        else
          format.html { render :new, locals: { license: license }, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize_action(license)
      if license.update(license_params)
        redirect_to admin_license_path(license), notice: 'License was updated'
      else
        render :show, locals: { license: license }, status: :unprocessable_entity
      end
    end

    def destroy
      authorize_action(license)
      license.discard
      respond_to do |format|
        format.html { redirect_to admin_clients_path, notice: 'The license was successfully removed.' }
        format.js {}
      end
    end

    def undiscard
      License.with_discarded.discarded.find(params[:id]).undiscard
      respond_to do |format|
        format.js {}
      end
    end

    private

    def license
      @license ||= scope.find(params[:id])
    end

    def authorize_action(record = License)
      authorize record, "#{action_name}?", policy_class: policy_class
    end

    def policy_class
      Admin::LicensePolicy
    end

    def scope
      policy_scope(License, policy_scope_class: Admin::LicensePolicy::Scope)
    end

    def license_params
      params.require(:license).permit(:client_id, :licensable_id, :licensable_type, :amount, :expires_at)
    end
  end
end
