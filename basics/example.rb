class Article
  attr_accessor :likes, :dislikes
  attr_reader :title, :body, :author, :created_at

  def initialize(title, body, author = nil)
    @title = title
    @body = body
    @author = author
    @created_at = Time.now
    @likes = 0
    @dislikes = 0
  end

  def like!
    @likes += 1
  end

  def dislike!
    @dislikes += 1
  end

  def points
    @likes - @dislikes
  end

  def votes
    @likes + @dislikes
  end

  def long_lines
    @body.lines.select { |line| line.size > 80 }
  end

  def length
    @body.size
  end

  def truncate(limit)
    if length > limit
      @body[0, limit - 3] + "..."
    else
      @body
    end
  end

  def contain?(pattern)
    @body.match(pattern) || @body.include?(pattern.to_s)
  end
end
