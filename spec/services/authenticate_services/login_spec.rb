require 'rails_helper'

RSpec.describe "ShowOffApi::AuthenticateService" do
  describe "#login" do
    context "when credentials is valid", :vcr do
      params = {
        username: "totoy101@yahoo.com",
        password: "password"
      }

      subject { ShowOffApi::AuthenticateService.login(params) }

      it "should return login successfully" do
        expect(subject.status).to eq 200
        expect(subject.token.present?).to eq true
      end
    end

    context "when credentials not valid", :vcr do
      params = {
        username: "not-exist-dasdasd@yahoo.com",
        password: "password"
      }

      subject { ShowOffApi::AuthenticateService.login(params) }

      it "should return login successfully" do
        expect(subject.errors['status']).to eq 422
        expect(subject.errors['message']).to eq "There was an error logging in. Please try again."
      end
    end
  end
end
