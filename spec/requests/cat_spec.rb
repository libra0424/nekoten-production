# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CatsController, type: :request do
  describe '#new' do
    it '投稿ページへのアクセス' do
      user = create(:user)
      sign_in user
      get "/cats/new"
      expect(response).to be_successful
    end
  end
end
