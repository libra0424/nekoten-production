# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CatsController, type: :request do
  let(:user){create(:user)}
  let(:other_user){create(:user2)}
  let(:create_cat){create(:cat)}
  let(:create_other_user_cat){create(:cat, user:other_user)}
  let(:cat_params){ attributes_for(:cat)}
  let(:invalid_cat_params){ attributes_for(:cat, name:"")}


  describe 'cat#new' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      
      it '投稿ページへのアクセスに成功する' do
        get new_cat_path
        expect(response).to be_successful
      end
    end

    context 'ログインしていない場合' do
      it '投稿ページへのアクセスに失敗する' do
        get new_cat_path
        expect(response).to_not be_successful
      end
    end
  end


  describe 'cat#create' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'cat#createへのアクセスが成功すること' do
        post cats_path, params: { cat: cat_params }
        expect(response.status).to eq 302 
      end

      it 'createが成功すること' do
        expect do
          post cats_path, params: { cat: cat_params }
          end.to change(Cat, :count).by 1
      end

      it 'create後リダイレクトされること' do
        post cats_path, params: { cat: cat_params }
        expect(response).to redirect_to cats_path
      end

      context 'パラメータが不正な場合(ログインしていて)' do
        it 'createが失敗すること' do
          expect do
            post cats_path, params: { cat: invalid_cat_params }
          end.to change(Cat, :count).by 0
        end

        it 'エラーが表示されること' do
          post cats_path, params: { cat: invalid_cat_params }
          expect(response.body).to include '猫の名前が入力されていません。'
        end
      end
    end

    context 'ログインしていない場合' do
      it 'createが失敗すること' do
        expect do
          post cats_path, params: { cat: cat_params }
        end.to change(Cat, :count).by 0
      end
    end
  end

  describe 'cat#index' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      
      it 'indexページへのアクセスに成功する' do
        get cats_path
        expect(response).to be_successful
      end
    end

    context 'ログインしていない場合' do
      it 'indexページへのアクセスに失敗する' do
        get cats_path
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
        get cat_path(create_cat.id)
        expect(response).to be_successful
      end
    end

    context 'ログインしていない場合' do
      it 'showページへのアクセスに失敗する' do
        get cat_path(create_cat.id)
        expect(response).to_not be_successful
      end
    end
  end

  describe '#destroy' do
    let(:current_user_cat){create(:cat,user_id:user.id)}
    context 'ログインしている場合' do
      before do
        sign_in user
        @cat = current_user_cat
      end
      it '削除リクエストが成功すること' do
        delete cat_path(@cat)
        expect(response.status).to eq 302
      end

      it 'deleteが成功すること' do
        expect do
          delete cat_path(@cat)
        end.to change(Cat, :count).by -1
      end

      it 'delete後リダイレクトされること' do
        delete cat_path(@cat)
        expect(response).to redirect_to cats_path
      end

      context 'ログインしいてるユーザーの投稿でない場合' do
        before do
          @cat = create_other_user_cat
        end
          
        it 'deleteできないこと' do
          expect do
            delete cat_path(@cat.id)
          end.to change(Cat, :count).by 0
        end
      end
    end

    context 'ログインしていない場合' do
      it 'destroyが失敗すること' do
        sign_in user
        @cat = create_cat
        sign_out user
        expect do
          delete cat_path(@cat.id)
        end.to change(Cat, :count).by 0
      end
    end
  end
end