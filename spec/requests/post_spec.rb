# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :request do

  describe '#new' do
    context 'ログインしている場合' do
      let(:user){create(:user)}
      before do
        sign_in user
      end

      it '投稿ページへのアクセスに成功する' do
        get "/posts/new"
        expect(response).to be_successful
      end
    end
  end
end
