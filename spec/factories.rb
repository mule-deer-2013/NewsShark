FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { "news" }
    password_confirmation { "news" }
  end

  factory :channel do
    name { "Egypt" }
    user
  end

  factory :article do 
    title { "Title" }
    url { 'http://www.spacex.com/webcast/' }
    channel
  end

end



