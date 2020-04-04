module ShowOffApi
  class Connection < ShowOffApi::BaseService
    class << self
      ENV["CLIENT_URL"] = "https://showoff-rails-react-production.herokuapp.com/api/v1"
      ENV["CLIENT_ID"] = "277ef29692f9a70d511415dc60592daf4cf2c6f6552d3e1b769924b2f2e2e6fe"
      ENV["CLIENT_SECRET"] = "d6106f26e8ff5b749a606a1fba557f44eb3dca8f48596847770beb9b643ea352"

      def api
        Faraday.new(url: ENV["CLIENT_URL"]) do |faraday|
          faraday.response :logger
          faraday.adapter Faraday.default_adapter
          faraday.headers['Accept-Version'] = '1.0'
          faraday.headers['Authorization'] = "Authorization #{ENV["TOKEN"]}"
        end
      end
    end
  end
end
