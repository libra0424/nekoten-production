# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let(:post){create(:post)}
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

    context 'ログインしていない場合' do
      it '投稿ページへのアクセスに失敗する' do
        get "/posts/new"
        expect(response).to_not be_successful
      end

      it '投稿に失敗する' do
      end
    end
  end
end
