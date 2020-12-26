class RenameFileColumnToImages < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :file, :image
  end
end
