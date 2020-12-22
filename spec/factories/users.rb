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
  factory :user_1, class: User do
    user_name { "MyString" }
    email { "MyString@hoge.com" }
    password { "MyString" }
    password_confirmation { "MyString" }
    # default
    use_task_5
    trait :use_task_5 do
      after(:build) do |user|
        create_list(:task_5, 5, user: user)
      end
    end
    trait :use_task_4 do
      after(:build) do |user|
        create_list(:task_4, 5, user: user)
      end
    end
    trait :use_task_6 do
      after(:build) do |user|
        create(:task_6, user: user)
      end
    end
    trait :use_task_3 do
      after(:build) do |user|
        create(:task_3, user: user)
      end
    end
  end
  factory :user_2, class: User do
    user_name { "MyString" }
    email { "MyString2@hoge.com" }
    password { "MyString" }
    password_confirmation { "MyString" }
  end
end
