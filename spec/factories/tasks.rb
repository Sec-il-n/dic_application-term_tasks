FactoryBot.define do
  sequence (:task_name_sequence) { |n| "タスク#{n}" }
  sequence :task_valid_sequence do |n|
    n = rand(10) * n
    Time.current.since(n.days)
  end

  factory :task do
    task_name { 'タスク' }
    details { 'テスト_詳細' }
  end

  factory :task_3, class: Task do
    task_name { generate :task_name_sequence }
    details { 'テスト_詳細3' }
    created_at { Time.current }#
    status { "#{["未着手", "着手中", "完了"].sample}" }
    valid_date { generate :task_valid_sequence }
    priority { "#{['高', '中', '低'].sample}" }
    association :user, factory: :user_1
  end
  factory :task_4, class: Task do
    task_name { generate :task_name_sequence }
    details { 'テスト_詳細3' }
    valid_date { "#{Time.current.since(10.days)}"  }
    status { "#{["未着手", "着手中", "完了"].sample}" }
    association :user, factory: :user_1
  end
  factory :task_5, class: Task do
    task_name { 'タスク' }
    details { 'テスト_詳細' }
    status { "#{["未着手", "着手中", "完了"].sample}" }
    valid_date { generate :task_valid_sequence }

    association :user, factory: :user_1
  end
  factory :task_6, class: Task do
    task_name { 'タスク234' }
    details { 'テスト_詳細' }
    status { "#{I18n.t('.dictionary.words.Not started')}" }
    valid_date { '002022-12-18'  }
  end
  factory :task_7, class: Task do
    task_name { generate :task_name_sequence }
    details { 'テスト_詳細3' }
    created_at { "#{5.days.ago}" }
    valid_date { "#{Time.current.since(10.days)}"  }
    status { "#{["未着手", "着手中", "完了"].sample}" }
    priority { "#{['高', '中', '低'].sample}" }

    user { label.user }
  end
end
