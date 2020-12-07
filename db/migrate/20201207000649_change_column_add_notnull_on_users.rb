class ChangeColumnAddNotnullOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :user_name, false
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
  end
end
