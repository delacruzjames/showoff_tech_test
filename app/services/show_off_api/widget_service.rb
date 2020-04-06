module ShowOffApi
  class WidgetService < ShowOffApi::BaseService
    class << self
      def index(access_token)
        ShowOffApi::Authorized::RequestService.get_json('api/v1/widgets', access_token)
      end
    end
  end
end


# ShowOffApi::WidgetService.index(current_user)
