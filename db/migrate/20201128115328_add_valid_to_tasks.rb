class AddValidToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :valid, :date, null: false, default: ''
  end
end
