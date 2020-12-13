class RenameValidColumnToValidDate < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :valid, :valid_date
  end
end
