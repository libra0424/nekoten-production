# frozen_string_literal: true

FactoryBot.define do
  factory :relationship do
    association :user
    user_id do
      [
        FactoryBot.build(:user)
      ]
    end
    follow_id do
      [
        FactoryBot.build(:user2)
      ]
    end
  end
end
