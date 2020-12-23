class RemoveCreatorFromGroups < ActiveRecord::Migration[5.2]
  def up
    remove_column :groups, :creator
  end
  def down
    add_column :groups, :creator, :bigint
  end
end
