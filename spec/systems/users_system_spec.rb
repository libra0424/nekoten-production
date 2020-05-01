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
    end
  end
end