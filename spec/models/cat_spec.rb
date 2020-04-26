# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cat, type: :model do
  context 'ログインしている場合' do
    before do
      user = create(:user)
      sign_in user
    end

    it 'ファクトリーデータの:catが登録に成功する' do
      post = create(:cat)
      expect(post).to be_valid
    end
  end
end