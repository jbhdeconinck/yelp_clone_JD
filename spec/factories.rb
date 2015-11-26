FactoryGirl.define do
  factory :user do
    email "hello@hello.com"
    password "password"
    password_confirmation "password"
  end

  factory :user2, class: User do
    email "hola@hello.com"
    password "password2"
    password_confirmation "password2"
  end
end
