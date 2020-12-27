class Manager < ApplicationRecord
  belongs_to :task, optional: true
  belongs_to :label, optional: true

  scope :search_by_label, -> (label_id) { where(label_id: label_id) }
end
