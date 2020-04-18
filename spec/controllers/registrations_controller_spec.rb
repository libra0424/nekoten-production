# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
  end

  describe '#edit' do
    # it "ユーザー編集ページへのアクセス" do
    #   get :edit, params: {id: @user.id }
    #   expect(response).to be_success
    # end
    it 'ユーザー名の更新を確認'
    it 'ユーザーのメールアドレスの更新を確認'
    it 'パスワードの変更を確認'
  end
end
