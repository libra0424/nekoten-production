# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe 'バリデーション' do
    it 'テストデータがバリデーションを通過すること' do
      expect(@user).to be_valid
    end

    it '名前が空だと登録できない' do
      @user.name = ''
      expect(@user).not_to be_valid
    end

    it '名前が50文字を超えると登録できない' do
      @user.name = 'a' * 51
      expect(@user).not_to be_valid
    end
  end

  describe ''
end
