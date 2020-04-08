module ShowOffApi
  class UserService < ShowOffApi::BaseService
    attr_accessor :user, :token

    def initialize(args={})
      super(args)
    end

    class << self
      def create(params)
        params[:client_id] = ENV["CLIENT_ID"]
        params[:client_secret] = ENV["CLIENT_SECRET"]
        response = ShowOffApi::RequestService.create('api/v1/users', params, {})
        response["status"] == 200 ? success(response) : errors(response)
      end

      def current_user(options)
        response = ShowOffApi::RequestService.where('api/v1/users/me', {}, options)
        response["status"] == 200 ? success(response) : errors(response)
      end

      def update(params, options)
        response = ShowOffApi::RequestService.put_json('api/v1/users/me', params, options)
        UserService.new(response)
      end

      def find(id, options)
        response = ShowOffApi::RequestService.get_json_with_token("api/v1/users/#{id}", {}, options)
        UserService.new(response)
      end

      def update_password(params, options)
        response = ShowOffApi::RequestService.post_json("api/v1/users/me/password", params, options)
        UserService.new(response)
      end

      def check_email(params)
        response = ShowOffApi::RequestService.get_json("api/v1/users/email", params)
        UserService.new(response)
      end

      def reset_password(params)
        response ShowOffApi::RequestService.post_json("api/v1/users/reset_password", params, {})
        UserService.new(response)
      end
    end
  end
end
