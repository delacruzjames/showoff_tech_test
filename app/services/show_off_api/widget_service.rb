module ShowOffApi
  class WidgetService < ShowOffApi::BaseService
    class << self
      def index(*args)
        ShowOffApi::RequestService.get_json(
          "api/v1/widgets/visible",
            {
              client_id: ENV["CLIENT_ID"],
              client_secret: ENV["CLIENT_SECRET"],
              term: args.empty? ? nil : args.join(",")
            }
          )
      end

      def create(params, options)
        ShowOffApi::RequestService.post_json('api/v1/widgets', params, options)
      end
    end
  end
end


# ShowOffApi::WidgetService.index(current_user)
