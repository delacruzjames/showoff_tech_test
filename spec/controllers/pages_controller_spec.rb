require 'rails_helper'

RSpec.describe PagesController do
  describe "#index" do
    context "when params search is present" do
      subject { get :index, params: {search: 'widget'} }

      it "render template" do
        expect(subject).to render_template(:index)
      end
    end

    context "when params search not present" do

    end
  end
end
