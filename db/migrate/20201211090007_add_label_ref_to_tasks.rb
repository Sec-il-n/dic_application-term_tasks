class AddLabelRefToTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :label, foreigin_key: true
  end
end
