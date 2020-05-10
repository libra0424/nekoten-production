# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  let(:user){create(:user)}
  let(:other_user){create(:user2)}
  let(:create_post){create(:post)}
  let(:create_other_user_comment){create(:comment, user:other_user)}
  let(:comment_params){ attributes_for(:comment,user_id:user.id,post_id:create_post.id)}
  let(:invalid_comment_params){ attributes_for(:comment_params, comment:"")}

  describe 'comment#create' do
    context 'ログインしている場合' do
      before do
        sign_in user
        @post = create_post
      end

      it 'comment#createへのアクセスが成功すること' do
        post post_comments_path(@post.id, format: :js), params: { comment: comment_params }
        expect(response.status).to eq 200
      end

      it 'createが成功すること' do
        expect do
          post post_comments_path(@post.id, format: :js), params: { comment: comment_params }
          end.to change(Comment, :count).by 1
      end
    end

    context 'ログインしていない場合' do
      before do
        @post = create_post
      end

      it 'createが失敗すること' do
        expect do
          post post_comments_path(@post.id, format: :js), params: { comment: comment_params }
        end.to change(Comment, :count).by 0
      end
    end
  end

  describe '#destroy' do
    let(:current_user_comment){create(:comment,user_id:user.id)}
    context 'ログインしている場合' do
      before do
        sign_in user
        @post = create_post
        @comment =create(:comment,user_id:user.id,post_id:@post.id)
      end

      it 'deleteが成功すること' do
        expect do
          delete post_comment_path(@post,@comment,format: :js)
        end.to change(Comment, :count).by -1
      end

      context 'ログインしいてるユーザーの投稿でない場合' do
        before do
          @other_comment = create(:comment, user:other_user) 
        end
          
        it 'deleteできないこと' do
          expect do
            delete post_comment_path(@post,@other_comment,format: :js)
          end.to change(Comment, :count).by 0
        end
      end
    end
  end
end