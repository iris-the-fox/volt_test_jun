class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, foreign_key: :post_id, dependent: :destroy
  validates :title, :body, presence: true
  default_scope { order(published_at: :desc) }
end
