require 'rails_helper'

RSpec.describe "ShowOffApi::WidgetService" do
  describe "#visible" do
    context "can able to access without token", :vcr do
      context "with term" do
        subject { ShowOffApi::WidgetService.visible(['james']) }
        it "should return list of widgets" do
          expect(subject.widgets.first['name']).to eq "James Bond's Widget"
          expect(subject.status).to eq 200
          expect(subject.widgets.present?).to eq true
        end
      end

      context "without term", :vcr do
        subject { ShowOffApi::WidgetService.visible }

        it "should return list of widgets" do
          expect(subject.status).to eq 200
          expect(subject.widgets.present?).to eq true
        end
      end
    end
  end
end
