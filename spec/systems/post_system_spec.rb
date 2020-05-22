# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user2) }
  let(:build_post) { build(:post) }
  let(:create_post) { create(:post) }
  let(:create_other_user_post) { create(:post, user: other_user) }
  let(:post_params) { attributes_for(:post) }
  let(:invalid_post_params) { attributes_for(:post, caption: '', photos: nil) } # タイトルも写真も空白

  describe '#create' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '投稿ページへのアクセスに成功する' do
        visit new_post_path
        expect(page).to have_content '投稿画面'
      end

      context 'パラメータが妥当な場合' do
        it '投稿できる' do
          expect do
            visit new_post_path
            fill_in 'post[caption]', with: build_post.caption
            attach_file 'post_photos_attributes_0_image', 'spec/test.png'
            click_button '投稿する'
          end.to change(Post, :count).by(1)
        end
      end
    end
  end

  describe '#destroy' do
    context 'ログインしている場合' do
      before do
        sign_in user
        @post = create(:post, user_id: user.id)
      end

      it '投稿詳細ページへのアクセスに成功する' do
        visit post_path(@post)
        expect(page).to have_selector '#comment_comment'
      end

      it '自分の投稿を削除できること' do
        visit post_path(@post)
        expect do
          find('.delete-post-icon').click
        end.to change(Post, :count).by(-1)
      end
    end
  end
end
