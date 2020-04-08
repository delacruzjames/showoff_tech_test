require 'faraday'
require 'json'

module ShowOffApi
  ENV["CLIENT_ID"] = '277ef29692f9a70d511415dc60592daf4cf2c6f6552d3e1b769924b2f2e2e6fe'
  ENV["CLIENT_SECRET"] = 'd6106f26e8ff5b749a606a1fba557f44eb3dca8f48596847770beb9b643ea352'
  class BaseService 
    attr_accessor :errors

    def initialize(args = {})
      args.each do |name, value|
        attr_name = name.to_s.underscore
        send("#{attr_name}=", value) if respond_to?("#{attr_name}=")
      end
    end
  end
end
