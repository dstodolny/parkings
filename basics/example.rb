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

class ArticlesFileSystem
  def initialize(dir)
    @dir = dir
  end

  def save(articles)
    articles.each do |article|
      file_name = article.title.downcase.gsub(/\s+/, "_") + ".article"
      file_body = [article.author, article.likes, article.dislikes, article.body].join("||")

      File.open(@dir + "/" + file_name, "w") { |file| file.write(file_body) }
    end
  end

  def load
    Dir.glob(@dir + "/*.article").map do |file_name|
      load_article(file_name)
    end
  end

  private

  def load_article(file_name)
    title = get_title(file_name)

    contents = File.read(file_name).split("||")

    article = Article.new(title, contents[3], contents[0])
    article.likes = contents[1].to_i
    article.dislikes = contents[2].to_i

    article
  end

  def get_title(file_name)
    file_name.match(/(\w+)\.article$/)[1].gsub("_", " ").capitalize
  end
end

class WebPage
  class NoArticlesFound < StandardError; end

  attr_reader :dir, :articles

  def initialize(dir = "/")
    @dir = dir
    @articles = load
  end

  def load
    ArticlesFileSystem.new(dir).load
  end

  def save
    ArticlesFileSystem.new(dir).save(articles)
  end

  def new_article(title, body, author)
    @articles << Article.new(title, body, author)
  end

  def longest_articles
    articles.sort_by { |article| article.body.size }.reverse
  end

  def best_articles
    articles.sort_by(&:points).reverse
  end

  def worst_articles
    best_articles.reverse
  end

  def best_article
    fail NoArticlesFound if @articles.empty?
    best_articles.first
  end

  def worst_article
    fail NoArticlesFound if @articles.empty?
    best_articles.last
  end

  def most_controversial_articles
    articles.sort_by(&:votes).reverse
  end
end
