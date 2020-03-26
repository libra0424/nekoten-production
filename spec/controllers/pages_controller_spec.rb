require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "#home" do
    subject { get :home}

    it 'http access success' do
      is_expected.to have_http_status(:success)
    end
  end
end
