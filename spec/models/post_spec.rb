# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    
    context 'ログインしている場合' do
      before do
        user = create(:user)
        sign_in user
      end
      
      it 'ファクトリーデータの:postが投稿に成功する確認' do
        post = create(:post)
        expect(post).to be_valid
      end
      
      it 'タイトルが文字数255文字を超える時バリデーションエラー' do
        post = create(:post)
        post.caption = "a" * 256
        expect(post).not_to be_valid
      end
      
      it 'タイトルも画像もない場合投稿エラー' do
        post = Post.new
        post.caption = nil
        post.photo_ids = nil
        post.save
        expect(post).not_to be_valid
      end     
    end

    context 'ログインしていない場合' do
      it '投稿に失敗する' do
        post = create(:post)
        expect(post).to be_valid
      end
    end
  end
end
