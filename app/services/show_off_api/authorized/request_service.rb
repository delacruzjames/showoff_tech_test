module ShowOffApi::Authorized
  class RequestService < ShowOffApi::BaseService
    class << self
      def post_json(path, params = {})
        response = api.post do |req|
          req.url path
          req.headers['Content-Type'] = 'application/json'
          req.body = params.to_json
        end
        [JSON.parse(response.body), response.status]
      end

      def get_json(path, access_token)
        response = Rails.cache.fetch(path, expires_in: 1.days, force: false) do
          api(access_token).get(path)
        end
        [JSON.parse(response.body), response.status]
      end

      def get_current_user(path, access_token)
        response = api(access_token).get(path)

        if JSON.parse(response.body)['data'].present?
          JSON.parse(response.body)['data']['user']
        end
      end

      def api(access_token)
        ShowOffApi::Authorized::ConnectionService.api(access_token)
      end
    end
  end
end
