class UserSerializer < ActiveModel::Serializer
   
  attributes :id, :nickname, :email

  attribute :posts_number
  attribute :comments_number

  def posts_number
    object.posts.count
  end

  def comments_number
    object.comments.count
  end

end
