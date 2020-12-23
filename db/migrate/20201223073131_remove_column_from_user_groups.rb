class RemoveColumnFromUserGroups < ActiveRecord::Migration[5.2]
  def change
    remove_reference :user_groups, :users, foreign_key: true
    remove_reference :user_groups, :groups, foreign_key: true
  end
end
