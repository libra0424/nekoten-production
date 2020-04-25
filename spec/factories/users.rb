# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'test' }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { 'testuser' }
    confirmed_at {Time.now}
  end
end
