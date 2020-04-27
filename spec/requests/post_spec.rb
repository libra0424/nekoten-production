# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let(:create_post){create(:post)}
  let(:post_params){ attributes_for(:post)}
  let(:photo_params){ attributes_for(:photo)}
  describe '#new' do
    context 'ログインしている場合' do
      let(:user){create(:user)}
      before do
        sign_in user
      end

      it '投稿ページへのアクセスに成功する' do
        get posts_path
        expect(response).to be_successful
      end

      it '投稿リクエストが成功すること' do
        post posts_path, params: { post: post_params }
        expect(response.status).to eq 302 
      end

      it 'createが成功すること' do
        expect do
          post posts_path, params: { post: post_params }
        end.to change(Post, :count).by 1
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
