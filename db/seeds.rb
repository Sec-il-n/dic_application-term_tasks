# 20.times do |n|
#   task_name = Faker::Name.name
#   details = 'テスト_詳細'
#   valid_date = Faker::Time.between_dates(from: Date.today, to: Date.today + 20)
#   status = ["未着手", "着手中", "完了"].sample
#   priority = [0, 1, 2].sample
#   # priority = (0..2).rand
#   user_id = (1..3).rand
#   Task.create!(
#     task_name: task_name,
#     details: details,
#     valid_date: valid_date,
#     status: status,
#     priority: priority,
#     user_id: user_id
#   )
# end

20.times do |n|
  task_name = Faker::Name.name
  details = 'テスト_詳細'
  valid_date = Faker::Time.between_dates(from: Date.today, to: Date.today + 20)
  status = ["未着手", "着手中", "完了"].sample
  priority = [0, 1, 2].sample
  user_id = 6
  Task.create!(
    task_name: task_name,
    details: details,
    valid_date: valid_date,
    status: status,
    priority: priority,
    user_id: user_id
  )
end

# 3.times do |n|
#   user_name = "ユーザー#{n}"
#   email= "user-#{n}@hoge#{n}.jp"
#   password = "password"
#   User.create!(
#     user_name: user_name,
#     email: email,
#     password: password,
#     password_confirmation: password,
#   )
# end
  User.create!(
    user_name: "admin",
    email: "admin@hoge.jp",
    password: "password",
    password_confirmation: "password",
    admin: true,
  )
