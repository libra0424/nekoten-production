require 'rails_helper'

RSpec.describe "ネコの機能", type: :system do
  let(:user){create(:user)}
  let(:build_cat){build(:cat)}

  describe '猫の登録について' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      
      it '投稿ページへのアクセスに成功する' do
        visit new_cat_path
        expect(page).to have_content '猫の名前'
      end

      context 'パラメータが妥当な場合' do
        it '猫を登録できる' do
          expect {
            visit new_cat_path       
            fill_in 'cat[name]', with: build_cat.name
            fill_in 'cat[cat_species]', with: build_cat.cat_species
            choose 'cat_gender_0'
            select_date("2020,1月,1" , from: "誕生日")
            fill_in 'cat[coatcolor]', with: build_cat.coatcolor
            click_button 'ウチの子に追加する'
          }.to change(Cat, :count).by(1)
        end
      end
    end
  end

  describe '#show' do
    context 'ログインしている場合' do
      before do
        sign_in user
        @cat = create(:cat,user_id:user.id)
      end
      
      it 'editページへのアクセスに成功する' do
        visit cat_path(@cat)
        expect(page).to have_content @cat.name
      end
    end
  end

  describe '#edit' do
    context 'ログインしている場合' do
      before do
        sign_in user
        @cat = create(:cat,user_id:user.id)
      end
      
      it 'editページへのアクセスに成功する' do
        visit edit_cat_path(@cat)
        expect(page).to have_content 'ウチの子の情報を変更'
        expect(page).to have_field '猫の名前', with: @cat.name

      end

      it '猫の名前を変更できる' do
        visit edit_cat_path(@cat)
        fill_in 'cat[name]', with: "#{build_cat.name}2"
        click_button 'ウチの子の情報を変更する'
        expect(page).to have_content "#{build_cat.name}2"
      end
    end
  end


  describe '#destroy' do
    context 'ログインしている場合' do
      before do
        sign_in user
        @cat = create(:cat,user_id:user.id)
      end
      
      it '投稿詳細ページへのアクセスに成功する' do
        visit cat_path(@cat)
        expect(page).to have_content @cat.name
      end

      it '自分の投稿を削除できること' do
        visit cat_path(@cat)
        expect{
          find('.delete-post-icon').click
        }.to change(Cat, :count).by(-1)
      end
    end
  end
end