# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RelationshipsController, type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user2) }
  let(:create_relationship) { create(:relationship) }

  describe 'relationship#create' do
    context 'ログインしている場合' do
      before do
        @other_user = other_user
        sign_in user
      end

      it 'createが成功すること' do
        expect do
          post relationships_path, params: { follow_id: @other_user.id }
        end.to change(Relationship, :count).by 1
      end
    end

    context 'ログインしていない場合' do
      before do
        @other_user = other_user
      end

      it 'createが失敗すること' do
        expect do
          post relationships_path, params: { follow_id: @other_user.id }
        end.to change(Relationship, :count).by 0
      end
    end
  end

  describe 'relationship#destroy' do
    context 'ログインしている場合' do
      before do
        @other_user = other_user
        sign_in user
        @relation = Relationship.create(user_id: user.id, follow_id: @other_user.id)
      end

      it 'destroyが成功すること' do
        expect do
          delete relationship_path(@relation), params: { follow_id: @other_user.id }
        end.to change(Relationship, :count).by -1
      end
    end

    context 'ログインしていない場合' do
      before do
        @other_user = other_user
        @relation = Relationship.create(user_id: user.id, follow_id: @other_user.id)
      end

      it 'destroyが失敗すること' do
        expect do
          delete relationship_path(@relation), params: { follow_id: @other_user.id }
        end.to change(Relationship, :count).by 0
      end
    end
  end
end
