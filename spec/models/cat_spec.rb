# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cat, type: :model do
  context 'ログインしている場合' do
    let(:user) {create(:user)}
    let(:cat) {create(:cat)}
    before do
      sign_in user
    end

    it 'ファクトリーデータの:catが登録に成功する' do
      expect(cat).to be_valid
    end

    it '名前が文字数50文字を超える時バリデーションエラー' do
      cat.name = "a" * 51
      expect(cat).not_to be_valid
    end

    it '名前がない時バリデーションエラー' do
      cat.name = nil
      expect(cat).not_to be_valid
    end

  end
end