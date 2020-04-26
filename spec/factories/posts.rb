# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    association :user
    caption {"test"}
    photos {[
      FactoryBot.build(:photo,post: nil)
    ]}
  end
end

FactoryBot.define do
  factory :photo do
    post
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/test.png')) }
  end
end
