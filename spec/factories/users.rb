# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'test' }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { 'testuser' }
    confirmed_at {Time.now}
  end

  factory :user2, class: User do
    name { 'test2' }
    sequence(:email) { |n| "TEST#{n}@example2.com" }
    password { 'testuser' }
    confirmed_at {Time.now}
  end
end
