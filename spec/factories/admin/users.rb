FactoryBot.define do
  sequence :email_sequence do |n|
    "test_admin_#{n}@hoge.com"
  end
  factory :admin, class: Admin::User do
    user_name { "admin_user" }
    email { generate :email_sequence }
    password { "password" }
    password_confirmation { "password" }
    admin { true }
  end
end
