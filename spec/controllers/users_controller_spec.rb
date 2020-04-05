require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = create(:user)
  end

    describe "#show" do
      it "ユーザー詳細ページへのアクセス" do
        get :show, params: {id: @user.id}
        expect(response).to be_success
      end
    end

    describe "#edit" do
      it "ユーザーeditページへのアクセス" 

      it "ユーザー名の更新を確認"
      it "ユーザーのメールアドレスの更新を確認"
      it "パスワードの変更を確認"
    end

end

