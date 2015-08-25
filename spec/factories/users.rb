FactoryGirl.define do
  factory :user do
    name 'John'
    surname 'Smith'
    email { |n| "legit_email#{n}@gmail.com" }
    password 'keyboard_cat'
    password_confirmation 'keyboard_cat'
    admin false
    factory :bad_user do
      name ''
      surname ''
      email '@'
      password 'a'
      password_confirmation 'asd'
    end
  end
end
