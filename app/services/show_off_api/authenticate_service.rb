module ShowOffApi
  class AuthenticateService < ShowOffApi::BaseService
    attr_accessor :access_token, :token_type, :expires_in,
                  :refresh_token, :scope, :create_at, :message

    def initialize(args={})
      super(args)
    end

    class << self
      def login(params)
        params[:client_id] = ENV["CLIENT_ID"]
        params[:client_secret] = ENV["CLIENT_SECRET"]
        params[:grant_type] = "password"
        response = ShowOffApi::RequestService.post_json('oauth/token', params, {})
        AuthenticateService.new(response.first.fetch('data').fetch('token'))
      end

      def revoke(params)
        response = ShowOffApi::RequestService.post_json('oauth/revoke', params, params)
        AuthenticateService.new(response.first.fetch('data'))
      end

      def refresh_token(params, options)
        params[:client_id] = ENV["CLIENT_ID"]
        params[:client_secret] = ENV["CLIENT_SECRET"]
        params[:grant_type] = "refresh_token"
        response = ShowOffApi::RequestService.post_json('oauth/token', params, params)
        AuthenticateService.new(response.first.fetch('data').fetch('token'))
      end
    end
  end
end
