# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = create(:user)
  end

  describe '#show' do
    it 'ユーザー詳細ページへのアクセス' do
      get :show, params: { id: @user.id }
      expect(response).to be_success
    end
  end
end
