# frozen_string_literal: true

FactoryBot.define do
  factory :cat do
    association :user
    name { 'testcat' }
    birthday { '2020-01-01' }
    cat_species { 'アメリカンショートヘア' }
    gender { '1' }
    coatcolor { '黒' }
    profile_photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/test.png')) }
  end
end
