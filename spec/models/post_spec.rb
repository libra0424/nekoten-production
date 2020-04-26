# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'create'

  before do
    user = create(:user)
    sign_in user
  end

  it 'postが成功する確認' do
    post = create(:post)
    expect(post).to be_valid
  end
end
