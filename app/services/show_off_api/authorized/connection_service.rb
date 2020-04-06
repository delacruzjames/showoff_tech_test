module ShowOffApi::Authorized
  class ConnectionService < ShowOffApi::BaseService
    class << self
      ENV["CLIENT_URL"] = "https://showoff-rails-react-production.herokuapp.com"

      def api(access_token)
        Faraday.new(url: ENV["CLIENT_URL"]) do |faraday|
          faraday.response :logger
          faraday.adapter Faraday.default_adapter
          faraday.headers['Accept-Version'] = '1.0'
          faraday.headers['Authorization'] = "Bearer #{access_token}"
        end
      end
    end
  end
end
