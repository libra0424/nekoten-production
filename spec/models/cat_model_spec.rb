# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cat, type: :model do
  describe '#create' do
    let(:cat) { create(:cat) }

    context 'ログインしている場合' do
      let(:user) { create(:user) }
      before do
        sign_in user
      end

      it 'ファクトリーデータの:catが登録に成功する' do
        expect(cat).to be_valid
      end

      it '名前が文字数50文字を超える時バリデーションエラー' do
        cat.name = 'a' * 51
        expect(cat).not_to be_valid
      end

      it '名前がない時バリデーションエラー' do
        cat.name = nil
        expect(cat).not_to be_valid
      end

      it '猫種が文字数50文字を超える時バリデーションエラー' do
        cat.cat_species = 'a' * 51
        expect(cat).not_to be_valid
      end

      it '毛色が文字数50文字を超える時バリデーションエラー' do
        cat.coatcolor = 'a' * 51
        expect(cat).not_to be_valid
      end

      it '誕生日が今日以降ならバリデーションエラー' do
        cat.birthday = Date.today.next_day(1)
        expect(cat).not_to be_valid
      end
    end

    context 'ログインしていない場合' do
      it 'ファクトリーデータの:catが登録に失敗する' do
      end
    end
  end
end
