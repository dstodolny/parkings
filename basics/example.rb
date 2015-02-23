class Article
  attr_accessor :likes, :dislikes
  attr_reader :title, :body, :author, :created_at

  def initialize(title, body, author)
    @title = title
    @body = body
    @author = author
  end
end
