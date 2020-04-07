require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "#new" do
    it "ユーザー詳細ページへのアクセス" do
      get :new
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "テストデータで投稿ができること"
    it "投稿成功時にrootにリダイレクト"
    it "投稿失敗時にrootにリダイレクト"

  end
end
