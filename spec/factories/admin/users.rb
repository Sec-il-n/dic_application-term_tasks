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
  # factory :admin, class: Admin::User do
  #   user_name { "admin_user" }
  #   email { "test_admin@hoge.com" }
  #   password { "password" }
  #   password_confirmation { "password" }
  #   # password_digest { "password" }
  #   # ↑のみだとバリデーションに引っかかる
  #   admin { true }
  # end

  # NameError:uninitialized constant Admin::User
  # factory :user, class: Admin::User do
  #   user_name { "MyString" }
  #   email { "MyString@hoge.com" }
  #   password { "MyString" }
  #   password_confirmation { "MyString" }
  # end
end
