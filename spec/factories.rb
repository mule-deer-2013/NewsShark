FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { "news" }
    password_confirmation { "news" }
  end

  factory :channel do
    name { "Pants" }
    user
  end

  factory :article do
    title { Faker::Lorem.word }
    url { Faker::Internet.url }
    channel
  end

end



