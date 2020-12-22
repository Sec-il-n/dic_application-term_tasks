class User < ApplicationRecord
  with_options presence: true do
    validates :user_name, length: { maximum: 30 }
    validates :email, length: { maximum:255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  end
  has_secure_password
  before_destroy :cannot_destroy_last_admin
  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy

  private
  def admin_exists?
    User.where(admin: true).count == 1
  end
  def cannot_destroy_last_admin
    throw(:abort) if admin_exists?
  end
end
