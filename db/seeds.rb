<<<<<<< HEAD
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
  user_ids = []
  user_ids << user.id

=======
# User.create!(
#   user_name: "admin",
#   email: "admin@hoge.jp",
#   password: "password",
#   password_confirmation: "password",
#   admin: true,
# )

# try もし修正でたら
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
  # user_ids = []
  # user_ids << user.id

>>>>>>> seed.rb修正
  task_name = Faker::Name.name
  details = 'テスト_詳細'
  valid_date = Faker::Time.between_dates(from: Date.today, to: Date.today + 20)
  status = ["未着手", "着手中", "完了"].sample
  priority = [0, 1, 2].sample
<<<<<<< HEAD
  user_id = user_ids.sample
  task = Task.create!(
    task_name: task_name,
    details: details,
    valid_date: valid_date,
    status: status,
    priority: priority,
    user_id: user_id
  )
=======
  user_id = user.id
  # user_id = user_ids.sample
  10.times do |n|
    task = Task.create!(
      task_name: task_name,
      details: details,
      valid_date: valid_date,
      status: status,
      priority: priority,
      user_id: user_id
    )
  end
>>>>>>> seed.rb修正

  label_name = "既成ラベル_#{n + 1}"
  label = Label.create!(label_name: label_name)
  # Managerクラスに　int, Label クラスは代入不可
    # task.managers << label_ids.sample
    # task.managers << label
  task.labels << label
end
<<<<<<< HEAD
=======
# 10.times do |n|
#   user_name = "ユーザー#{n}"
#   email= "user__user#{n}@hoge#{n}.jp"
#   password = "password"
#   user = User.create!(
#     user_name: user_name,
#     email: email,
#     password: password,
#     password_confirmation: password,
#   )
#   user_ids = []
#   user_ids << user.id
#
#   task_name = Faker::Name.name
#   details = 'テスト_詳細'
#   valid_date = Faker::Time.between_dates(from: Date.today, to: Date.today + 20)
#   status = ["未着手", "着手中", "完了"].sample
#   priority = [0, 1, 2].sample
#   user_id = user_ids.sample
#   task = Task.create!(
#     task_name: task_name,
#     details: details,
#     valid_date: valid_date,
#     status: status,
#     priority: priority,
#     user_id: user_id
#   )
#
#   label_name = "既成ラベル_#{n + 1}"
#   label = Label.create!(label_name: label_name)
#   # Managerクラスに　int, Label クラスは代入不可
#     # task.managers << label_ids.sample
#     # task.managers << label
#   task.labels << label
# end
>>>>>>> seed.rb修正
