20.times do |n|
  task_name = Faker::Name.name
  details = 'テスト_詳細'
  valid_date = Faker::Time.between_dates(from: Date.today, to: Date.today + 20)
  status = ["未着手", "着手中", "完了"].sample
  priority = [0, 1, 2].sample
  Task.create!(
    task_name: task_name,
    details: details,
    valid_date: valid_date,
    status: status,
    priority: priority,
  )
end
