class Group < ApplicationRecord
  with_options presence: true do
    validates :group_name, length: { maximum: 20 }
    # validates :creator
  end
  has_many :user_groups, foreign_key: 'group_id'
  has_many :users, through: :user_groups
end
