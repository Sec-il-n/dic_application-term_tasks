User.create!(
  user_name: "admin",
  email: "admin@hoge.jp",
  password: "password",
  password_confirmation: "password",
  admin: true,
)

10.times do |n|
  user_name = "ユーザー#{n}"
  email= "user__user#{n}@hoge#{n}.jp"
  password = "password"
  user = User.create!(
    user_name: user_name,
    email: email,
    password: password,
    password_confirmation: password,
  )

  task_name = Faker::Name.name
  details = 'テスト_詳細'
  valid_date = Faker::Time.between_dates(from: Date.today, to: Date.today + 20)
  status = ["未着手", "着手中", "完了"].sample
  priority = [0, 1, 2].sample
  user_id = user.id

  task = Task.create!(
    task_name: task_name,
    details: details,
    valid_date: valid_date,
    status: status,
    priority: priority,
    user_id: user_id
  )

  label_name = "既成ラベル_#{n + 1}"
  label = Label.create!(label_name: label_name)
  task.labels << label
end
