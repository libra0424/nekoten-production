# frozen_string_literal: true

FactoryBot.define do
  factory :relationship do
    association :user
    user_id {[
      FactoryBot.build(:user)
    ]}
    follow_id {[
      FactoryBot.build(:user2)
    ]}
  end
end


