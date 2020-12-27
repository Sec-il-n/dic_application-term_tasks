class RenameLabelNemeColumnToLabels < ActiveRecord::Migration[5.2]
  def change
    rename_column :labels, :label_neme, :label_name
  end
end
