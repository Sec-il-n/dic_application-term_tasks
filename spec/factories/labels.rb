FactoryBot.define do
  i = 0
  sequence (:label_names) { |n| "label_#{i += 1}" }
  # sequence (:label_names) { |n| "label_#{n}" }
  factory :label do
    label_name { generate :label_names }
    association :user
    # undefined method　←先に要manager?
    # ActiveRecord::AssociationTypeMismatch:User(#70239587116260) expected, got インスタンス
    after(:create) do |label|
    # after(:build) do |task_7|
      # メールアドレスはすでに存在します
      create_list(:task_7, 3, labels: [label], user_id: label.user_id)
      # labels: = label_ids: の意味(?) labelが実行されるごとに、idを[]格納
      # 3回実行されるtask_7にそれぞれ同一のlabel_idが入る。user側でlabelのcreate_listをしても、1のタスクに複数のラベルをつけられるわけではない。
    end
  end
end
