require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { build(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, name: "") }

  describe 'user#create' do
    before do
      ActionMailer::Base.deliveries.clear
    end
    context 'パラメータが妥当な場合' do
      it '認証メールが送信される' do
        visit new_user_registration_path       
        fill_in 'user[email]', with: user.email
        fill_in 'user[name]', with: user.name
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password
        click_button '登録する'
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end
      
      it 'createが成功すること' do
        expect do
          visit new_user_registration_path   
          post user_registration_path, params: { user: user_params}
        end.to change(User, :count).by 1
      end
      
      # it 'リダイレクトされること' do
      #   post user_registration_path, params: { user: user_params }
      #   expect(response).to redirect_to root_url
      # end
    end

    context 'パラメーターが不正な場合' do
      it 'メールが重複した場合エラーメッセージが表示される' do
        user.save
        visit new_user_registration_path       
        fill_in 'user[email]', with: user.email
        fill_in 'user[name]', with: user.name
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password
        click_button '登録する'
        expect(page).to have_content 'メールアドレスは既に使用されています。'
      end

      it '名前が空白の場合エラーメッセージが表示される' do
        visit new_user_registration_path       
        fill_in 'user[email]', with: user.email
        fill_in 'user[name]', with: ''
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password
        click_button '登録する'
        expect(page).to have_content '名前が入力されていません'
      end

      it 'createが失敗すること' do
        expect do
          post user_registration_path, params: { user: invalid_user_params}
        end.to_not change(User, :count)
      end

    end
  end
end