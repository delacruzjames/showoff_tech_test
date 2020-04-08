require 'rails_helper'

RSpec.describe "ShowOffApi::UserService" do
  describe "#current_user" do
    context "when access_token is present", :vcr do
      before do
        params = {
          "user" =>  {
            "first_name" => "totoy",
            "last_name" => "totoy",
            "email" => "current_user103@yahoo.com",
            "password" => "password"
          }
        }

        @user = ShowOffApi::UserService.create(params)
      end

      subject { ShowOffApi::UserService.current_user(token: @user.token["access_token"]) }

      it "return details for current_user" do
        expect(subject.user['email']).to eq "current_user103@yahoo.com"
        expect(subject.status).to eq 200
      end
    end

    context "when access_token is nil", :vcr do
      subject { ShowOffApi::UserService.current_user(token: nil) }

      it "return nil for current_user" do
        expect(subject.errors.present?).to eq true
        expect(subject.errors["message"]).to eq "Your session has expired. Please login again to continue."
      end
    end
  end
end
