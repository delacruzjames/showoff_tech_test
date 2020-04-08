require 'rails_helper'

RSpec.describe "ShowOffApi::WidgetService" do
  describe "#index" do
    include_context "generate_token"

    context "with term", :vcr do
      subject { ShowOffApi::WidgetService.index('New', token: @token) }

      it "should return widget with New record" do
        expect(subject.status).to eq 200
        expect(subject.widgets.present?).to eq true
      end
    end

    context "without term", :vcr do
      subject { ShowOffApi::WidgetService.index(token: @token) }

      it "should return all widgets for current_user" do
        expect(subject.status).to eq 200
        expect(subject.widgets.present?).to eq true
      end
    end
  end
end
