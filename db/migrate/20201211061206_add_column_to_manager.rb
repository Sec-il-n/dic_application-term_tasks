class AddColumnToManager < ActiveRecord::Migration[5.2]
  def change
     add_reference :managers, :task, foreign_key: true
     add_reference :managers, :label, foreign_key: true
  end
end
