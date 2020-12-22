class Task < ApplicationRecord
  with_options presence: true do
    validates :task_name, length:{ maximum:60 }
    validates :details, length:{ maximum:255 }
    validates :valid_date
    validates :status
  end
  validate :not_before_today
  def not_before_today
    errors.add(:valid_date, 'は今日以降の日付を選択してください。') if valid_date.nil? || valid_date < Date.current
  end

  scope :recent, -> { order(created_at: :DESC) }
  scope :search_status, -> (status) { where(status: status) }
  scope :search_name_like, -> (name) { where('task_name LIKE ?', "%#{name}%") }
  scope :order_valid, -> { order(valid_date: :ASC) }
  scope :order_priority, -> { order(priority: :DESC ) }
  # scope :tasks_of_user, -> (user_id) { where(user_id: user_id) }
  enum priority:['低' ,'中' ,'高']
  belongs_to :user
  has_many :managers, dependent: :destroy, foreign_key: 'task_id'
  # has_many :labels, through: :managers, source: :label
  #修正後
  # has_many :labels, through: :managers, source: :task
  has_many :labels, through: :managers
  # accepts_nested_attributes_for :managers
  # accepts_nested_attributes_for :labels
end
