require 'rails_helper'

RSpec.describe LikesController, type: :system do
  let(:user){create(:user)}
  let(:other_user){create(:user2)}
  let(:post){create(:post,user:other_user)}

  describe 'likes#create' do
    context 'ログインしている場合' do
      before do
        @post = post
        sign_in user
      end

      context 'ログインしていてかつ他のユーザーの投稿' do
        it 'いいねできる' ,js: true do
            visit post_path(@post)
            click_on 'いいね'
            expect(page).to have_content 'が「いいね！」しました'
        end
      end
    end
  end

  describe 'likes#destroy' do
    context 'ログインしている場合' do
      before do
        @post = post
        sign_in user
        visit post_path(@post)
        click_on 'いいね'
        expect(page).to have_content 'が「いいね！」しました'
      end

      context 'ログインしていてかつ他のユーザーの投稿' do
        it 'いいね解除できる' ,js: true do
            visit post_path(@post)
            click_on 'いいねを取り消す'
            expect(page).to have_selector '.love'
        end
      end
    end
  end
end