require 'faraday'
require 'json'

module ShowOffApi
  class ConnectionService < ShowOffApi::BaseService
    ENV["CLIENT_URL"] = "https://showoff-rails-react-production.herokuapp.com"
    class << self
      def api
        Faraday.new(url: ENV["CLIENT_URL"]) do |faraday|
          faraday.response :logger
          faraday.adapter Faraday.default_adapter
          faraday.headers['Accept-Version'] = '1.0'
        end
      end

      def api_with_token(token)
        Faraday.new(url: ENV["CLIENT_URL"]) do |faraday|
          faraday.response :logger
          faraday.adapter Faraday.default_adapter
          faraday.headers['Accept-Version'] = '1.0'
          faraday.headers['Authorization'] = "Bearer #{token}"
        end
      end
    end
  end
end
