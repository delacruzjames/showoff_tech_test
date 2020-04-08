require 'rails_helper'

RSpec.describe "ShowOffApi::UserService" do
  describe "#create" do
    context "when parameter is valid" do
      params = {
        "user" =>  {
          "first_name" => "totoy",
          "last_name" => "totoy",
          "email" => "totoy101@yahoo.com",
          "password" => "password"
        }
      }

      subject { ShowOffApi::UserService.create(params) }
      it "return success", :vcr do
        expect(subject.token.present?).to eq true
        expect(subject.user['name']).to eq ("#{params['user']['first_name']} #{params['user']['last_name']}")
        expect(subject.user['email']).to eq ("#{params['user']['email']}")
      end
    end

    context "when parameter not valid" do
      params = {
        "user" =>  {
          "first_name" => "totoy",
          "last_name" => "totoy",
          "email" => "totoy101@yahoo.com",
          "password" => "password"
        }
      }

      subject { ShowOffApi::UserService.create(params) }
      it "return email is already exist", :vcr do
        expect(subject.errors['status']).to eq 422
        expect(subject.errors['message']).to eq "A user with that email already exists"
      end
    end
  end
end
