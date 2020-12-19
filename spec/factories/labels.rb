FactoryBot.define do
  sequence (:label_names) { |n| "label_#{n}" }
  # sequence :label_names do |n|
  #   "label_#{n}"
  # end
  factory :label do
    label_name { generate :label_names }
    # { アソシエーション名.同? }
    association :user
    # undefined method　←先に要manager?
    # ActiveRecord::AssociationTypeMismatch:User(#70239587116260) expected, got インスタンス
    # after(:create) do |label,user|
    after(:create) do |label|
    # after(:build) do |task_7|
      # メールアドレスはすでに存在します
      create_list(:task_7, 3, labels: [label], user_id: label.user_id)
      # labels: = label_ids: の意味(?) labelが実行されるごとに、idを[]格納
      # 3回実行されるtask_7にそれぞれ同一のlabel_idが入る。user側でlabelのcreate_listをしても、1のタスクに複数のラベルをつけられるわけではない。
    end
    # after(:create) do |label|
    #   task = create(:task_7)
    #   create(:manager, label: label, task: task )
    # end
    # after(:build) do |label|　|label, user|　　
    # 　　　　　　　　　　　　　　　　　　　　　　　⤵︎create  task{ user.tasks[].id }
    # create(:manager, label: label, task: user.tasks[].id  )
    # end
  end
end
