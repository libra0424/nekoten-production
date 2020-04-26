# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    let(:post){create(:post)}
    
    context 'ログインしている場合' do
      let(:user){create(:user)}
      before do
        sign_in user
      end
      
      it 'ファクトリーデータの:postが投稿に成功する確認' do
        expect(post).to be_valid
      end
      
      it 'タイトルが文字数255文字を超える時バリデーションエラー' do
        post.caption = "a" * 256
        expect(post).not_to be_valid
      end
      
      it 'タイトルと画像の両方がない場合バリデーションエラー' do
        post.caption = nil
        post.photo_ids = nil
        expect(post).not_to be_valid
      end     
    end

    context 'ログインしていない場合' do
      it '投稿に失敗する' do
        expect(post).to be_valid
      end
    end
  end
end
