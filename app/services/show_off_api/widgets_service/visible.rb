module ShowOffApi::WidgetsService
    class Visible < ShowOffApi::BaseService
      class << self
        def index(*args)
          ShowOffApi::Visible::RequestService.get_json(
            "api/v1/widgets/visible", {
              client_id: ENV["CLIENT_ID"],
              client_secret: ENV["CLIENT_SECRET"],
              term: args.empty? ? nil : args.join(",")
              }
            )
        end
      end
    end
  end

# Index only
# ShowOffApi::WidgetsService::Visible.index
# Index with term
# ShowOffApi::WidgetsService::Visible.index('test')
# Create widgets record
# ShowOffApi::WidgetsService::Visible.create({widget: {name: "name", description: "description", kind: "visible"}})
