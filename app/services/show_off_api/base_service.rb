require 'faraday'
require 'json'

module ShowOffApi
  ENV["CLIENT_ID"] = '277ef29692f9a70d511415dc60592daf4cf2c6f6552d3e1b769924b2f2e2e6fe'
  ENV["CLIENT_SECRET"] = 'd6106f26e8ff5b749a606a1fba557f44eb3dca8f48596847770beb9b643ea352'
  class BaseService
    attr_accessor :errors, :status, :message

    def initialize(args = {})
      args.each do |name, value|
        attr_name = name.to_s.underscore
        send("#{attr_name}=", value) if respond_to?("#{attr_name}=")
      end
    end

    class << self
      def success(response)
        if response.fetch('data').nil?
          self.new(response)
        else
          self.new(response.fetch('data').merge(
            "status" => response["status"],
            "message" => response["message"])
          )
        end
      end

      def errors(response)
        self.new(response)
      end
    end
  end
end
