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

      def index(params, options)
        params[:client_id] = ENV["CLIENT_ID"]
        params[:client_secret] = ENV["CLIENT_SECRET"]
        if options[:token].present?
          response = ShowOffApi::RequestService.where("api/v1/users/me/widgets", params, options)
        else
          response = ShowOffApi::RequestService.where("api/v1/widgets/visible", params, options)
        end
        response.fetch('data').fetch('widgets', []).map{|widget| WidgetService.new(widget)}
      end

      def save(params, options)
        response = ShowOffApi::RequestService.create('api/v1/widgets', params, options)
        response["status"] == 200 ? success(response) : errors(response)
      end

      def update(id, params, options)
        params[:widget] = params[:widget].except('id', 'kind')
        ShowOffApi::RequestService.update("api/v1/widgets/#{id}", params, options)
      end

      def destroy(id, options)
        ShowOffApi::RequestService.delete("api/v1/widgets/#{id}", options)
      end
    end
  end
end


# ShowOffApi::WidgetService.index(current_user)
