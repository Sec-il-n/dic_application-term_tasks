FactoryBot.define do
  factory :user do
    user_name { "MyString" }
    email { "MyString@hoge.com" }
    password { "MyString" }
    password_confirmation { "MyString" }

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
  factory :user_2, class: User do
    user_name { "MyString" }
    email { "MyString2@hoge.com" }
    password { "MyString" }
    password_confirmation { "MyString" }
  end
end
# trait association先　factory内で連鎖して呼び出す場合、association先の有無で分岐(呼ぶ呼ばない)できる。
    # trait :labels do
    #
    # end
