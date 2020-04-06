module ShowOffApi
  class RequestService < ShowOffApi::BaseService
    class << self
      def create(resource_path, query = {}, options = {})
        response, status = post_json(resource_path, query, options)
        status == 200 ? success(response) : errors(response)
      end

      def where(resource_path, query = {}, options = {})
        response, status = get_json(resource_path, query)
        status == 200 ? response : errors(response)
      end

      def errors(response)
        error = { errors: { status: response["status"], message: response["message"] } }
        response.merge(error)
      end

      def success(response)
        success = { status: 200, message: response["message"] }
        response = response['data']['widget']
        response.merge(success)
      end

      def get_json(root_path, query = {})
        query_string = query.map{|k,v| "#{k}=#{v}"}.join("&")
        path = query.empty? ? root_path : "#{root_path}?#{query_string}"
        response = api.get(path)
        [JSON.parse(response.body), response.status]
      end

      def post_json(path, params = {}, options={})
        if options[:token].present?
          response = api_with_token(options[:token]).post do |req|
            req.url path
            req.headers['Content-Type'] = 'application/json'
            req.body = params.to_json
          end
        else
          response = api.post do |req|
            req.url path
            req.headers['Content-Type'] = 'application/json'
            req.body = params.to_json
          end
        end
        [JSON.parse(response.body), response.status]
      end

      def api
        ShowOffApi::ConnectionService.api
      end

      def api_with_token(token)
        ShowOffApi::ConnectionService.api_with_token(token)
      end
    end
  end
end
