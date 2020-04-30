require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  context 'ファクトリーボット'
  it 'ユーザー新規登録' do
    visit new_user_registration_path
    expect(page).to have_field 'ユーザーネーム'
  end
end