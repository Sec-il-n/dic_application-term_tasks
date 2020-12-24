class AddColumnAlreadyReadToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :already_read, :boolean, default: false, null: false
  end
end
