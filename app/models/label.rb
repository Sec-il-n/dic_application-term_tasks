class Label < ApplicationRecord
  validates :label_name, presence: true, length: { maximum: 20 }
  
  belongs_to :user, optional: true
  has_many :tasks, through: :managers, source: :label
end
