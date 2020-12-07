class User < ApplicationRecord
  with_options presence: true do
    validates :user_name, length: { maximum: 30 }
    validates :email, length: { maximum:255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
    validates :password, length: {  minimum: 6 }, confirmation: true
    validates :password_confirmation
  end
  has_secure_password
  has_many :tasks
end
