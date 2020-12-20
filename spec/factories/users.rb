FactoryBot.define do
  factory :user do
    user_name { "MyString" }
    email { "MyString@hoge.com" }
    password { "MyString" }
    password_confirmation { "MyString" }
# 追加
# step4 login_as_user の　userを別名にする。（labelがuserしか使えない為（?））
    admin { false }

    # # after(:build) do |user|#stack level too deep
    after(:create) do |user|
      create_list(:label, 3, user_id: user.id)
      # create(:label, user_id: user.id)
      # user.labels << create_list(:label, 3, user_id: user.id)
      # binding.pry
      # user.tasks << create_list(:task_7, 5, user_id: user.id)
    end
  end
# user_1を追加<-step4
  factory :user_2, class: User do
    user_name { "MyString" }
    email { "MyString2@hoge.com" }
    password { "MyString" }
    password_confirmation { "MyString" }
  end
end
