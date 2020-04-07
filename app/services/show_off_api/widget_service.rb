module ShowOffApi
  class WidgetService < ShowOffApi::BaseService
    attr_accessor :id, :name, :description, :kind, :owner, :status, :message

    # belongs_to :user, class_name: 'ShowOffApi::UserService'

    def initialize(args={})
      super(args)
    end

    class << self
      def index(*args)
        response = ShowOffApi::RequestService.get_json(
          "api/v1/widgets/visible",
            {
              client_id: ENV["CLIENT_ID"],
              client_secret: ENV["CLIENT_SECRET"],
              term: args.empty? ? nil : args.join(",")
            }
          )
        WidgetService.new(response)
      end

      def save(params, options)
        response = ShowOffApi::RequestService.create('api/v1/widgets', params, options)
        WidgetService.new(response)
      end

      def update(id, params, options)
        response = ShowOffApi::RequestService.update("api/v1/widgets/#{id}", params, options)
        WidgetService.new(response)
      end

      def destroy(id, options)
        response = ShowOffApi::RequestService.delete("api/v1/widgets/#{id}", options)
        WidgetService.new(response)
      end
    end
  end
end


# ShowOffApi::WidgetService.index(current_user)
