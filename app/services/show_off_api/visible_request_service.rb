module ShowOffApi
  class VisibleRequestService < ShowOffApi::BaseService
    class << self
      def get_json(path, query={})
        query_string = query.map{|k,v| "#{k}=#{v}"}.join("&")
        path = query.empty? ? path : "#{path}?#{query_string}"
        response = api.get(path)
        [JSON.parse(response.body), response.status]
      end

      def api
        ShowOffApi::ConnectionService.visible_api
      end
    end
  end
end
