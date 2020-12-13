class ChangeValidDateToNull < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :valid_date, :date, null: false
  end
end
