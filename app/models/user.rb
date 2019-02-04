class User < ApplicationRecord
	has_secure_password
	validates :nickname, :email, :password, presence: true
	has_many :posts, foreign_key: :author_id, dependent: :destroy
	has_many :comments, foreign_key: :author_id, dependent: :destroy
end
