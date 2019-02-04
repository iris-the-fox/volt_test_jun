class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  validates :title, :body, presence: true
end
