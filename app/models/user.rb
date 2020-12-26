class User < ApplicationRecord
  with_options presence: true do
    validates :user_name, length: { maximum: 30 }
    validates :email, length: { maximum:255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
    validates :password, length: {  minimum: 6 }#, confirmation: true
    # validates :password_confirmation
  end
  has_secure_password
  before_destroy :cannot_destroy_last_admin
  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy
  # scope :group_admin, -> { where(admin: true) }
  has_many :user_groups, foreign_key: 'user_id'
  has_many :groups, through: :user_groups
  mount_uploader :image, ImageUploader
  private
  def admin_exists?
    User.where(admin: true).count == 1
    # User.find_by(admin: true).count == 1
    # User.find_by(admin: true).present?
  end
  def cannot_destroy_last_admin
    throw(:abort) if admin_exists?
  end
end
