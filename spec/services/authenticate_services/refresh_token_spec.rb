require 'rails_helper'

RSpec.describe "ShowOffApi::AuthenticateService" do
  describe "#refresh_token" do
    include_context "generate_token"
    context "trigger refresh token action", :vcr do
      params = {
        "refresh_token" => "77c424e398e6780b493d914d4de6f657399b2ce4ab14b1c38e524f3f51051065"
      }

      subject { ShowOffApi::AuthenticateService.refresh_token(params, token: @token) }

      it "should update the user details" do
        expect(subject.status).to eq 200
        expect(subject.token.present?).to eq true
      end
    end
  end
end
