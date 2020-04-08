module ShowOffApi
  class RequestService < ShowOffApi::BaseService
    class << self
      def update(resource_path, params = {}, options = {})
        response, status = put_json(resource_path, params, options)
        status == 200 ? success(response, status) : errors(response, status)
      end

      def create(resource_path, params = {}, options = {})
        response, status = post_json(resource_path, params, options)
        status == 200 ? success(response, status) : errors(response, status)
      end

      def where(resource_path, query = {}, options = {})
        if options[:token].present?
          response, status = get_json_with_token(resource_path, query, options)
        else
          response, status = get_json(resource_path, query)
        end
        status == 200 ? success(response, status) : errors(response, status)
      end

      def errors(response, status)
        errors = { errors: {"status" => status, "message" => response['message']} }
        response.merge(errors)
      end

      def success(response, status)
        success = { "status" => status, "message" => response["message"] }
        response.merge(success)
      end

      def get_json(root_path, query = {})
        query_string = query.map{|k,v| "#{k}=#{v}"}.join("&")
        path = query.empty? ? root_path : "#{root_path}?#{query_string}"
        response = Rails.cache.fetch(path, expires_in: 1.days, force: false) do
          api.get(path)
        end
        [JSON.parse(response.body), response.status]
      end

      def get_json_with_token(root_path, query, options)
        query_string = query.map{|k,v| "#{k}=#{v}"}.join("&")
        path = query.empty? ? root_path : "#{root_path}?#{query_string}"
        response = api_with_token(options[:token]).get(path)
        [JSON.parse(response.body), response.status]
      end

      def delete(path, options={})
        response = api_with_token(options[:token]).delete do |req|
          req.url path
          req.headers['Content-Type'] = 'application/json'
        end
        response = { mesage: JSON.parse(response.body)['message'], status: response.status }
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

      def put_json(path, params={}, options={})
        response = api_with_token(options[:token]).put do |req|
          req.url path
          req.headers['Content-Type'] = 'application/json'
          req.body = params.to_json
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
