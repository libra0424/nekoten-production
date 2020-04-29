# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  let(:user){create(:user)}
  let(:other_user){create(:user2)}
  let(:create_post){create(:post)}
  let(:create_comment){create(:comment)}
  let(:create_other_user_comment){create(:comment, user:other_user)}
  let(:comment_params){ attributes_for(:comment)}
  let(:invalid_comment_params){ attributes_for(:comment, comment:"")}

  describe 'comment#create' do
    context 'ログインしている場合' do
      before do
        sign_in user
        @post = create_post
      end

      it 'comment#createへのアクセスが成功すること' do
        binding.pry
        post post_comments_path(@post.id), params: { comment: comment_params }
        expect(response.status).to eq 302
      end

      it 'createが成功すること' do
        expect do
          post post_comments_path, params: { comment: comment_params }
          end.to change(Comment, :count).by 1
      end

      it 'create後、表示されること' 
        # post comments_path, params: { comment: comment_params }
        # expect(response).to 

      context 'パラメータが不正な場合(ログインしていて)' do
        it 'createが失敗すること' do
          expect do
            post post_comments_path, params: { comment: invalid_comment_params }
          end.to change(Comment, :count).by 0
        end
      end
    end

    context 'ログインしていない場合' do
      it 'createが失敗すること' do
        expect do
          post post_comments_path, params: { comment: comment_params }
        end.to change(Comment, :count).by 0
      end
    end
  end

  describe '#destroy' do
    let(:current_user_comment){create(:comment,user_id:user.id)}
    context 'ログインしている場合' do
      before do
        sign_in user
        @comment = current_user_comment
      end
      it '削除リクエストが成功すること' do
        delete post_comment_path(@comment)
        expect(response.status).to eq 302
      end

      it 'deleteが成功すること' do
        expect do
          delete post_comment_path(@comment)
        end.to change(Comment, :count).by -1
      end

      it 'delete後表示が消えること' 
        # delete comment_path(@comment)
        # expect(response).to redirect_to comments_path

      context 'ログインしいてるユーザーの投稿でない場合' do
        before do
          @comment = create_other_user_comment
        end
          
        it 'deleteできないこと' do
          expect do
            delete post_comment_path(@comment.id)
          end.to change(Comment, :count).by 0
        end
      end
    end

    context 'ログインしていない場合' do
      it 'destroyが失敗すること' do
        sign_in user
        @comment = create_comment
        sign_out user
        expect do
          delete post_comment_path(@comment.id)
        end.to change(Comment, :count).by 0
      end
    end
  end
end