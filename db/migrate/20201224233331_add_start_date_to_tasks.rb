class AddStartDateToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :start_time, :datetime
  end
end
