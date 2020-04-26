# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe '#new' do
    it '投稿ページへのアクセス' do
      user = create(:user)
      sign_in user
      get :new
      expect(response).to be_successful
    end
  end

 

end
