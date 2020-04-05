module ShowOffApi::Visible
  class ConnectionService < ShowOffApi::BaseService
    class << self
      ENV["CLIENT_URL"] = "https://showoff-rails-react-production.herokuapp.com/api/v1"

      def api
        Faraday.new(url: ENV["CLIENT_URL"]) do |faraday|
          faraday.response :logger
          faraday.adapter Faraday.default_adapter
          faraday.headers['Accept-Version'] = '1.0'
        end
      end
    end
  end
end
