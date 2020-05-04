# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :request do
  let(:user){create(:user)}
  let(:other_user){create(:user2)}
  let(:create_post){create(:post,user:other_user)}


  describe 'like#create' do
    context 'ログインしている場合' do
      before do
        @post = create_post
        sign_in user
      end

      it 'createが成功すること' do
        expect do
          post post_likes_path(@post, format: :js), params: { post_id: @post.id }
          end.to change(Like, :count).by 1
      end
    end

    context 'ログインしていない場合' do
      before do
        @post = create_post
      end

      it 'createが失敗すること' do
        expect do
          expect do
            post post_likes_path(@post, format: :js), params: { post_id: @post.id }
          end.to change(Like, :count).by 0
        end
      end
    end
  end

  describe 'like#destroy' do
    context 'ログインしている場合' do
      before do
        sign_in user
        @post = create_post
        @like = create(:like,user:other_user,post:@post)
      end

      it 'destoryが成功すること' do
        expect do
          delete post_like_path(@post.id, id:@like.id, format: :js)
          end.to change(Like, :count).by -1
      end
    end

    context 'ログインしていない場合' do
      before do
        @post = create_post
        @like = create(:like,user:other_user,post:@post)
      end

      it 'destoryが失敗すること' do
        expect do
          delete post_like_path(@post.id, id:@like.id, format: :js)
          end.to change(Like, :count).by 0
      end
    end
  end
end