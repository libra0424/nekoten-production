require 'rails_helper'

RSpec.describe CatsController, type: :system do
  let(:user){create(:user)}
  let(:build_cat){build(:cat)}
  let(:create_cat){create(:cat)}
  let(:cat_params){ attributes_for(:cat)}


  describe '#create' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      
      it '投稿ページへのアクセスに成功する' do
        visit new_cat_path
        expect(page).to have_content '猫の名前'
      end

      context 'パラメータが妥当な場合' do
        it '投稿できる' do
          expect {
            visit new_cat_path       
            fill_in 'cat[name]', with: build_cat.name
            fill_in 'cat[cat_species]', with: build_cat.cat_species
            choose 'cat_gender_0'
            select_date("2019,1,1" , from: "誕生日")
            fill_in 'cat[coatcolor]', with: build_cat.coatcolor
            click_button 'ウチの子に追加する'
          }.to change(Cat, :count).by(1)
        end
      end
    end
  end

  describe '#destroy' do
    context 'ログインしている場合' do
      before do
        sign_in user
        @post = create(:post,user_id:user.id)
      end
      
      it '投稿詳細ページへのアクセスに成功する' do
        visit post_path(@post)
        expect(page).to have_selector '#comment_comment'
      end

      it '自分の投稿を削除できること' do
        visit post_path(@post)
        expect{
          find('.delete-post-icon').click
        }.to change(Post, :count).by(-1)
      end
    end
  end
end