require 'rails_helper'

RSpec.describe RelationshipsController, type: :system do
  let(:user){create(:user)}

  describe '#create' do
    context 'ログインしている場合' do
      before do
        @other_user = create(:user2)
        sign_in user
      end

      context '自分意外のユーザー' do
        it 'フォローできる' ,js:true do
            visit user_path(@other_user)
            click_button 'Follow'
            expect(page).to have_content 'ユーザーをフォローしました'
        end
      end
    end
  end

  describe '#destroy' do
    context 'ログインしている場合' do
      before do
        @other_user = create(:user2)
        sign_in user
      end
      
      it 'フォロー解除できる' ,js:true do
        visit user_path(@other_user)
        click_button 'Follow'
        sleep 0.5
        click_button 'Unfollow'
        expect(page).to have_content 'ユーザーのフォローを解除しました'
      end
    end
  end
end