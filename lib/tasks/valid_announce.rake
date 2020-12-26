namespace :valid_announce do
  # タスクの説明
  desc "期限間近のタスク保持者へメール送信"
  # タスク名：：appの環境を読み込む→クラスが使えるようになる
  task send_mail: :environment do
    puts 'hello'
  end
end
