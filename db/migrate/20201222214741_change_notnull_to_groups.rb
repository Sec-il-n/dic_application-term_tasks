class ChangeNotnullToGroups < ActiveRecord::Migration[5.2]
  def change
    change_column_null :groups, :group_name, false
    change_column_null :groups, :creator, false
  end
end
