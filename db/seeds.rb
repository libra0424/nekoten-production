users = [
  { email: "test5@test.com",
    created_at: "2020-05-26 01:19:53", 
    updated_at: "2020-05-26 01:19:53", 
    name: "エリカ", 
    password: "aslkdfjljk",
    confirmed_at: "2020-05-26 01:19:53",
    profile_photo: nil },
  { email: "test2@test.com",
    created_at: "2020-05-26 01:19:53", 
    updated_at: "2020-05-26 01:19:53", 
    name: "ひなぎく", 
    password: "aslkdfjljk",
    confirmed_at: "2020-05-26 01:19:53",
    profile_photo: nil },
  { email: "test3@test.com",
    created_at: "2020-05-26 01:19:53", 
    updated_at: "2020-05-26 01:19:53", 
    name: "ルーナ", 
    password: "aslkdfjljk",
    confirmed_at: "2020-05-26 01:19:53",
    profile_photo: nil },
  { email: "test4@test.com",
    created_at: "2020-05-26 01:19:53", 
    updated_at: "2020-05-26 01:19:53", 
    name: "ロア", 
    password: "aslkdfjljk",
    confirmed_at: "2020-05-26 01:19:53",
    profile_photo: nil },
  
]
ActiveRecord::Base.transaction do
  users.each do |user|
    User.create!(user)
  end
end