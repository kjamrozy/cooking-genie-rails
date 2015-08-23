FactoryGirl.define do
  factory :user do
    name 'John'
    surname 'Smith'
    email 'legit_email@gmail.com'
    password 'keyboard_cat'
    password_confirmation 'keyboard_cat'
    admin false
  end
end
