module ShowOffApi
  class AuthenticateService < ShowOffApi::BaseService
    attr_accessor :token

    def initialize(args={})
      super(args)
    end

    class << self
      def login(params)
        params[:client_id] = ENV["CLIENT_ID"]
        params[:client_secret] = ENV["CLIENT_SECRET"]
        params[:grant_type] = "password"
        response = ShowOffApi::RequestService.create('oauth/token', params, {})
        response["status"] == 200 ? success(response) : errors(response)
      end

      def revoke(params)
        response = ShowOffApi::RequestService.post_json('oauth/revoke', params, params)
        binding.pry
        response["status"] == 200 ? success(response) : errors(response)
      end

      def refresh_token(params, options)
        params[:client_id] = ENV["CLIENT_ID"]
        params[:client_secret] = ENV["CLIENT_SECRET"]
        params[:grant_type] = "refresh_token"
        response = ShowOffApi::RequestService.post_json('oauth/token', params, params)
        AuthenticateService.new(response)
      end
    end
  end
end
