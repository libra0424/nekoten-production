# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#create' do
    let(:comment){create(:comment)}

    it 'ファクトリーデータの:commentが投稿に成功する確認' do
      expect(comment).to be_valid
    end
    
    describe 'パラメータが不正な場合' do
      it 'コメントに失敗する' do
        comment.comment = ""
        expect(comment).to_not be_valid
      end
    end
    
  end
end
