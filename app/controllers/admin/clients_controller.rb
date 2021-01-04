# frozen_string_literal: true

module Admin
  class ClientsController < AdminController
    before_action :authorize_action
    def index
      render :index, locals: {
        clients: scope.kept.paginate(page: params[:page])
      }
    end

    def new
      render :new, locals: { client: Client.new }
    end

    def create
      client = Client.create(client_params)
      if client.save
        redirect_to admin_client_path(client), notice: 'Client was successfully created.'
      else
        render :new, locals: { client: client }, status: :unprocessable_entity
      end
    end

    def show
      authorize_action(client)
      search_users = User.active_options_for_select(User.where.not(id: client.client_users.select(:user_id)))
      licenses = client.licenses.active.kept.paginate(page: params[:page])
      render :show, locals: { client: client, search_users: search_users, licenses: licenses }
    end

    def update
      authorize_action(client)
      if client.update(client_params)
        redirect_to admin_clients_path, notice: "Client #{helpers.link_to(client.name, admin_client_path(client))} was updated"
      else
        render :show, locals: { client: client }, status: :unprocessable_entity
      end
    end

    def licenses
      render :licenses, locals: {
        licenses: client.licenses.paginate(page: params[:page]),
        client: client
      }
    end

    def candidates
      render :candidates, locals: {
        candidates: client.candidates.scope.paginate(page: params[:page]),
        client: client
      }
    end

    def examinations
      client = scope.find(params[:client_id])
      render :examinations, locals: {
        examinations: client.examinations.scope.paginate(page: params[:page]),
        client: client
      }
    end

    def add_user
      result = client.client_users.create(user_id: params.dig(:add_user, :user_id))
      respond_to do |format|
        format.js { render :add_user, locals: { user: result.user } }
      end
    end

    def add_candidate
      result = client.client_candidates.create(candidate_id: params.dig(:add_candidate, :candidate_id))
      respond_to do |format|
        format.js { render :add_candidate, locals: { candidate: result.candidate } }
      end
    end

    def add_license
      result = client.licenses.create(license_id: params.dig(:add_license, :license_id))
      respond_to do |format|
        format.js { render :add_license, locals: { license: result.license } }
      end
    end

    def destroy
      client.discard
      respond_to do |format|
        format.html { redirect_to admin_clients_path, notice: 'The client was successfully destroyed.' }
      end
    end

    private

    def client
      @client ||= scope.find(params[:id] || params[:client_id])
    end

    def authorize_action(record = Client)
      authorize record, "#{action_name}?", policy_class: policy_class
    end

    def policy_class
      Admin::ClientPolicy
    end

    def scope
      policy_scope(Client, policy_scope_class: Admin::ClientPolicy::Scope)
    end

    def client_params
      params.require(:client).permit(:name, :billing_info, :org_id)
    end
  end
end
