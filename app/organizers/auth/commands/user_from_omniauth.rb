# frozen_string_literal: true

module Auth
  module Commands
    class UserFromOmniauth < Micro::Service::Strict
      attribute :oauth_hash

      def call!
        if (user = from_oauth!)
          User.current = user
          Success(user: user)
        else
          Failure('Could not create user')
        end
      rescue ActiveRecord::RecordInvalid
        Failure('Could not create user. Email exists in database already.')
      end

      private

      def from_oauth!
        find_user_by_identity || create_from_oauth
      end

      def create_from_oauth
        ActiveRecord::Base.transaction do
          @user = User.create!(
            email: oauth_hash.dig(:info, :email),
            fname: oauth_hash.dig(:info, :first_name),
            lname: oauth_hash.dig(:info, :last_name),
            password: SecureRandom.hex(8)
          )
          @user.identities.create!(uid: oauth_hash.fetch(:uid), provider: oauth_hash.fetch(:provider))
        end
        @user
      end

      def find_user_by_identity
        User
          .joins(:identities)
          .find_by(identities: {
                     uid: oauth_hash.fetch(:uid),
                     provider: oauth_hash.fetch(:provider)
                   })
      end
    end
  end
end
