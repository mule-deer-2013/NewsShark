FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password "news"
    password_confirmation "news"
  end

   factory :member do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password "news"
    password_confirmation "news"
  end

  factory :channel do
    name "Pants"
    user
    member

    factory :channel_with_articles do
      after(:create) do |channel|
        15.times { create(:article, channel: channel) }
      end
    end
  end

  factory :article do
    title { Faker::Lorem.sentence }
    url { Faker::Internet.url }
    channel
  end

end
