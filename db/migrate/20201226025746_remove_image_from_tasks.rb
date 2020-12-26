class RemoveImageFromTasks < ActiveRecord::Migration[5.2]
  def up
    remove_column :tasks, :image
  end
  def down
    add_column :tasks, :image, :string
  end
end
