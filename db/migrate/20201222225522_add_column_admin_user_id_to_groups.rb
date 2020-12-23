class AddColumnAdminUserIdToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :admin_user_id, :bigint, null: false 
  end
end
