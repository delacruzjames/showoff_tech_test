module ShowOffApi::Visible
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

      def get_json(path, query={})
        query_string = query.map{|k,v| "#{k}=#{v}"}.join("&")
        path = query.empty? ? path : "#{path}?#{query_string}"
        response = api.get(path)
        [JSON.parse(response.body), response.status]
      end

      def api
        ShowOffApi::Visible::ConnectionService.api
      end
    end
  end
end
