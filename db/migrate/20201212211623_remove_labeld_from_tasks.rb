class RemoveLabeldFromTasks < ActiveRecord::Migration[5.2]
  def up
    remove_column :tasks, :label_id
  end

  def down
    add_column :tasks, :label_id, :bigint
  end
end
