FactoryBot.define do
  sequence (:task_name_sequence) { |n| "タスク#{n}" }
  # sequence :task_name_sequence do |n|
  #   "タスク#{n}"
  # end
  sequence :task_valid_sequence do |n|
    n = rand(10) * n
    Time.current.since(n.days)
    # Time.current.since(n.days)
  end

  factory :task do
    task_name { 'タスク' }
    details { 'テスト_詳細' }
  end
  # factory :task_2, class: Task do
  #   task_name { 'タスク2' }
  #   details { 'テスト_詳細2' }
  # end

  factory :task_3, class: Task do
    task_name { generate :task_name_sequence }
    details { 'テスト_詳細3' }
    created_at { Time.current }#
    status { "#{["未着手", "着手中", "完了"].sample}" }
    valid_date { generate :task_valid_sequence }
    # 追記
    priority { "#{['高', '中', '低'].sample}" }
    # priority { "#{[1, 2, 3].sample}" }
  end
  # factory :task_4, class: Task do
  #   task_name { generate :task_name_sequence }
  #   details { 'テスト_詳細3' }
  #   created_at { "#{5.days.ago}" }
  #   valid_date { "#{Time.current.since(10.days)}"  }
  #   # valid_date { Time.current += 10 }
  # end
  factory :task_5, class: Task do
    # task_name = [*'a'..'z'].shuffle[0..9]
    # task_name = ('a'..'z').to_a.shuffle[0..9]
    # task_name { "#{task_name}" }
    task_name { 'タスク' }
    details { 'テスト_詳細' }
    status { "#{["未着手", "着手中", "完了"].sample}" }
    valid_date { '002020-12-18'  }
  end
  # factory :task_6, class: Task do
  #   task_name { 'タスク234' }
  #   details { 'テスト_詳細' }
  #   status { "#{I18n.t('.dictionary.words.Not started')}" }
  #   valid_date { '002020-12-18'  }
  # end
  # 現在使用中  3,5 テスト書き直しと、↓使用できるかを確認
  factory :task_7, class: Task do
    task_name { generate :task_name_sequence }
    details { 'テスト_詳細3' }
    created_at { "#{5.days.ago}" }
    valid_date { "#{Time.current.since(10.days)}"  }
    status { "#{["未着手", "着手中", "完了"].sample}" }
    priority { "#{['高', '中', '低'].sample}" }
    # バリデーションに失敗しました: メールアドレスはすでに存在します
    # association :user, strategy: :build#,admin = true
    user { label.user }
    # user { label.user }
    # user消すと　→Userを入力してください
    # association :user, factory: :user_2
    # 中間テーブル作成
    # trait アソシエーション先を作るか作らないか切り替え可能

    # task  undefined local variable or method
    # ActiveRecord::AssociationTypeMismatch:
      # Label(#70350793543320) expected, got #<Task id: ...priority: "高", user_id: nil> which is an instance of Task(#70350769869060)
      # -> label_ids[] が必要なので　labels。rbの方にafter_create記載

    # after(:create) do |task_7|
    # # after(:build) do |task_7|
    #   # メールアドレスはすでに存在します
    #   create_list(:label, 3, tasks: [task_7])
    # # after(:build) do |task_7,user|
    #   # task_7.managers << create(:manager, task_id: task_7.id, label_id: user.labels)#.each.id
    # end
    # after(:build) do |task_7|
    # # after(:create) do |task_7|
    #   label_list = create_list(:label,3)
    #   task_7.managers << create(:manager, task_id: task_7.id, label_id: label_list[0].id)
    #   task_7.managers << create(:manager, task_id: task_7.id, label_id: label_list[1].id)
    #   task_7.managers << create(:manager, task_id: task_7.id, label_id: label_list[2].id)
    # end
  end
end
