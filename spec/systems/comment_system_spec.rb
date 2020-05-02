require 'rails_helper'

RSpec.describe CommentsController, type: :system do
  let(:user){create(:user)}
  let(:create_post){create(:post)}

  describe '#create' do
    context 'ログインしている場合' do
      before do
        sign_in user
        @post = create_post
      end

      context 'パラメータが妥当な場合' do
        it 'コメントを投稿できる',js: true  do
          visit post_path(@post)
          fill_in 'comment[comment]', with: 'これはテストコメントです。'+ "\n"
          sleep 1
          expect(page).to have_content 'これはテストコメントです。'
        end
      end
    end
  end

  describe '#destroy' do
    context 'ログインしている場合' do
      before do
        sign_in user
        @post = create_post
      end
      

      it 'コメントを削除できる',js: true  do
        visit post_path(@post)
        fill_in 'comment[comment]', with: 'これはテストコメントです。'+ "\n"
        find('.delete-comment').click
        expect(page).to_not have_content 'これはテストコメントです。'
      end
    end
  end
end