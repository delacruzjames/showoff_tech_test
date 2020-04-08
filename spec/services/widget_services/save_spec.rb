require 'rails_helper'

RSpec.describe "ShowOffApi::WidgetService" do
  describe "#save" do
    include_context "generate_token"

    context "valid parameters", :vcr do
      params = {
      	"widget": {
      		"name": "A Hidden Widget New",
      		"description": "Widget 1 New",
      		"kind": "hidden"
      	}
      }

      subject { ShowOffApi::WidgetService.save(params, token: @token) }

      it "should create new record" do
        expect(subject.status).to eq 200
        expect(subject.widget.present?).to eq true
      end
    end

    context "invalid parameters", :vcr do
      params = {
      	"widget": {
      		"name": "",
      		"description": "",
      		"kind": "hidden"
      	}
      }

      subject { ShowOffApi::WidgetService.save(params, token: @token) }

      it "should create new record" do
        expect(subject.errors['status']).to eq 422
        expect(subject.widget.present?).to eq false
      end
    end
  end
end
