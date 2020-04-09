module ShowOffApi
  class WidgetService < ShowOffApi::BaseService
    attr_accessor :widgets, :widget

    # belongs_to :user, class_name: 'ShowOffApi::UserService'

    def initialize(args={})
      super(args)
    end

    class << self
      def visible(*term)
        params = {}
        params[:client_id] = ENV["CLIENT_ID"]
        params[:client_secret] = ENV["CLIENT_SECRET"]
        params[:term] = term.empty? ? nil: term.join("")
        response = ShowOffApi::RequestService.where("api/v1/widgets/visible", params, {})
        response["status"] == 200 ? success(response) : errors(response)
      end

      def index(*term, options)
        params = {}
        params[:client_id] = ENV["CLIENT_ID"]
        params[:client_secret] = ENV["CLIENT_SECRET"]
        params[:term] = term.empty? ? nil: term.join("")
        response = ShowOffApi::RequestService.where("api/v1/widgets", params, options)
        response["status"] == 200 ? success(response) : errors(response)
      end

      def save(params, options)
        response = ShowOffApi::RequestService.create('api/v1/widgets', params, options)
        response["status"] == 200 ? success(response) : errors(response)
      end

      def update(id, params, options)
        params[:widget] = params[:widget].except('id', 'kind')
        response = ShowOffApi::RequestService.update("api/v1/widgets/#{id}", params, options)
        response["status"] == 200 ? success(response) : errors(response)
      end

      def destroy(id, options)
        response = ShowOffApi::RequestService.remove("api/v1/widgets/#{id}", {}, options)
        response["status"] == 200 ? success(response) : errors(response)
      end
    end
  end
end


# ShowOffApi::WidgetService.index(current_user)
