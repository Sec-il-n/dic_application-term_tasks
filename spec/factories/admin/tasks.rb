FactoryBot.define do
  factory :task_8, class: Admin::Task do
    task_name { generate :task_name_sequence }
    details { 'テスト_詳細3' }
    created_at { "#{5.days.ago}" }
    valid_date { "#{Time.current.since(10.days)}"  }
    user_id { 1 }
  end
end
