class AddRefToUserGroups < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_groups, :users, foreign_key: true
    add_reference :user_groups, :groups, foreign_key: true
  end
end
