class CommentSerializer < ActiveModel::Serializer
  attribute :to_post  
  attributes :body, :published_at

  attribute :author_nickname
  


  def author_nickname
    object.author.nickname
  end

  def to_post
    object.post.title
  end

end
