# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    association :post
    association :user
    user_id {[
      FactoryBot.build(:user)
    ]}
    post_id {[
      FactoryBot.build(:post)
    ]}
  end
end


