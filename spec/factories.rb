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
    url { 'http://www.businessweek.com/articles/2013-09-26/womens-black-pants-are-boring-and-sad' }
    channel
  end

end



