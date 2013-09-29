FactoryGirl.define do
  factory :user do
    email 'thomas@me.com'
    first_name 'Thomas'
    last_name 'Landon'
    password '123notit'
    password_confirmation '123notit'
  end
end