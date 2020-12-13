class ChangeValidDateToAllowNull < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :valid_date, :date, null: true
  end
end
