module ShowOffApi
  class UserService < ShowOffApi::BaseService
    attr_accessor :id, :name,  :first_name, :last_name, :date_of_birth,
                  :email, :action, :access_token, :refresh_token

    def initialize(args={})
      super(args)
    end

    class << self
      def create(params)
        params[:client_id] = ENV["CLIENT_ID"]
        params[:client_secret] = ENV["CLIENT_SECRET"]
        response = ShowOffApi::RequestService.create('api/v1/users', params, {})
        UserService.new(response)
      end

      def current_user(options)
        response = ShowOffApi::RequestService.get_json_with_token('api/v1/users/me', options)
        UserService.new(response.first.fetch('data').fetch('user'))
      end

      def login(options)
        response = ShowOffApi::RequestService.get_json_with_token('api/v1/users', options)
        UserService.new(response)
      end
    end
  end
end
