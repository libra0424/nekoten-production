# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let(:user){create(:user)}
  let(:other_user){create(:user2)}
  let(:create_post){create(:post)}
  let(:create_other_user_post){create(:post, user:other_user)}
  let(:post_params){ attributes_for(:post)}
  let(:invalid_post_params){ attributes_for(:post, caption:"", photos: nil)} #タイトルも写真も空白


  describe '#new' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      
      it '投稿ページへのアクセスに成功する' do
        get new_post_path
        expect(response).to be_successful
      end
    end

    context 'ログインしていない場合' do
      it '投稿ページへのアクセスに失敗する' do
        get new_post_path
        expect(response).to_not be_successful
      end
    end
  end


  describe '#create' do
    context 'ログインしている場合' do
      before do
        sign_in user
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

      it 'create後リダイレクトされること' do
        post posts_path, params: { post: post_params }
        expect(response).to redirect_to user_path(user)
      end

      context 'パラメータが不正な場合(ログインしていて)' do
        it 'createが失敗すること' do
          expect do
            post posts_path, params: { post: invalid_post_params }
          end.to change(Post, :count).by 0
        end

        it 'エラーが表示されること' do
          post posts_path, params: { post: invalid_post_params }
          expect(response.body).to include 'タイトルまたは写真が入力されていません。'
        end
      end
    end

    context 'ログインしていない場合' do
      it 'createが失敗すること' do
        expect do
          post posts_path, params: { post: post_params }
        end.to change(Post, :count).by 0
      end
    end
  end

  describe '#index' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      
      it 'indexページへのアクセスに成功する' do
        get posts_path
        expect(response).to be_successful
      end
    end

    context 'ログインしていない場合' do
      it 'indexページへのアクセスに失敗する' do
        get posts_path
        expect(response).to_not be_successful
      end
    end
  end

  describe '#show' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'showページへのアクセスに成功する' do
        get post_path(create_post.id)
        expect(response).to be_successful
      end
    end

    context 'ログインしていない場合' do
      it 'showページへのアクセスに失敗する' do
        get post_path(create_post.id)
        expect(response).to_not be_successful
      end
    end
  end

  describe '#destroy' do
    let(:current_user_post){create(:post,user_id:user.id)}
    context 'ログインしている場合' do
      before do
        sign_in user
        @post = current_user_post
      end
      it '削除リクエストが成功すること' do
        delete post_path(@post)
        expect(response.status).to eq 302
      end

      it 'deleteが成功すること' do
        expect do
          delete post_path(@post)
        end.to change(Post, :count).by -1
      end

      it 'delete後リダイレクトされること' do
        delete post_path(@post)
        expect(response).to redirect_to root_path
      end

      context 'ログインしいてるユーザーの投稿でない場合' do
        before do
          @post = create_other_user_post
        end
          
        it 'deleteできないこと' do
          expect do
            delete post_path(@post.id)
          end.to change(Post, :count).by 0
        end
      end
    end

    context 'ログインしていない場合' do
      it 'destroyが失敗すること' do
        sign_in user
        @post = create_post
        sign_out user
        expect do
          delete post_path(@post.id)
        end.to change(Post, :count).by 0
      end
    end
  end
end