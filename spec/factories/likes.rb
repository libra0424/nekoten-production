# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    association :post
    association :user
    user_id do
      [
        FactoryBot.build(:user)
      ]
    end
    post_id do
      [
        FactoryBot.build(:post)
      ]
    end
  end
end
