require 'rails_helper'

RSpec.describe "ShowOffApi::UserService" do
  describe "#update" do
    include_context "generate_token"

    context "with valid params", :vcr do
      params = {
        "user" => {
          "first_name" => "Another",
          "last_name" => "User",
          "date_of_birth" => 1464083530,
          "image_url" => "https://static.thenounproject.com/png/961-200.png"
        }
      }

      subject { ShowOffApi::UserService.update(params, token: @token) }

      it "should update the user details" do
        expect(subject.status).to eq 200
        expect(subject.user.present?).to eq true
      end
    end

    context "with not valid params" do
      params = {
        "user" => {
          "first_name" => "",
          "last_name" => "",
          "date_of_birth" => 0,
          "image_url" => "https://static.thenounproject.com/png/961-200.png"
        }
      }

      subject { ShowOffApi::UserService.update(params, token: @token) }

      it "should return error message" do
        expect(subject.errors.present?).to eq true
        expect(subject.errors['status']).to eq 422
      end
    end
  end
end
