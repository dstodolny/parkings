require 'minitest/autorun'
require './example'
require 'tmpdir'

class ArticleTest < Minitest::Test
  def setup
    @article = Article.new("foo", "bar", "baz")
  end

  def test_initialization
    assert_equal "foo", @article.title
    assert_equal "bar", @article.body
    assert_equal "baz", @article.author
    assert_equal 0    , @article.likes
    assert_equal 0    , @article.dislikes
    assert_equal Time , @article.created_at.class
    assert @article.created_at < Time.now
  end

  def test_initialization_with_anonymous_author
    article = Article.new("foo", "bar")
    assert_equal nil, article.author
  end

  def test_liking
    3.times { @article.like! }
    assert_equal 3, @article.likes
  end

  def test_disliking
    3.times { @article.dislike! }
    assert_equal 3, @article.dislikes
  end

  def test_points
    3.times { @article.like! }
    2.times { @article.dislike! }
    assert_equal 1, @article.points
  end

  def test_long_lines
    body = ["20***" * 4, "80***" * 16, "100**" * 20].join("\n")
    article = Article.new("foo", body)

    assert_kind_of Array, article.long_lines
    assert_equal ["80***" * 16 + "\n", "100**" * 20], article.long_lines
  end

  def test_truncate
    body = "100**" * 20
    article = Article.new("foo", body)

    assert_equal 80, article.truncate(80).size
    assert_equal "100**10...", article.truncate(10)
  end

  def test_truncate_when_limit_is_longer_then_body
    body = "100**" * 20
    article = Article.new("foo", body)

    assert_equal body, article.truncate(120)
  end

  def test_truncate_when_limit_is_same_as_body_length
    body = "100**" * 20
    article = Article.new("foo", body)

    assert_equal body, article.truncate(100)
  end

  def test_length
    body = "100**" * 20
    article = Article.new("foo", body)

    assert_equal 100, article.length
  end

  def test_votes
    3.times { @article.like! }
    3.times { @article.dislike! }

    assert_equal 6, @article.votes
  end

  def test_contain
    body = "abcdefghijklmnopqrstuwxyz"
    article = Article.new("foo", body)

    assert article.contain?("klm")
    assert article.contain?(/[f-i]{4}/)
    assert_equal false, article.contain?("kkk")
  end
end

class ArticlesFileSystemTest < Minitest::Test
  def setup
    @dir = Dir.mktmpdir
    @fs = ArticlesFileSystem.new(@dir)
    @article1 = Article.new("Article1", "Lorem ipsum" * 2, "John Doe")
    @article2 = Article.new("Article 2", "Lorem ipsum" * 3)

    2.times { @article1.like! }
    @articles = [@article1, @article2]
  end

  def teardown
    FileUtils.rm_rf(@dir)
  end

  def test_saving
    @fs.save(@articles)
    assert_equal ["#{@dir}/article1.article", "#{@dir}/article_2.article"], Dir["#{@dir}/*.article"].sort
    assert_equal "John Doe||2||0||Lorem ipsumLorem ipsum", File.read("#{@dir}/article1.article")
    assert_equal "||0||0||Lorem ipsumLorem ipsumLorem ipsum", File.read("#{@dir}/article_2.article")
  end

  def test_loading
    File.write(@dir + "/article1.article", "John Doe||2||0||Lorem ipsumLorem ipsum")
    File.write(@dir + "/article_2.article", "||0||0||Lorem ipsumLorem ipsumLorem ipsum")
    File.write(@dir + "/foobar", "||0||0||Lorem ipsumLorem ipsumLorem ipsum")
    articles = @fs.load.sort_by(&:title)
    assert_equal ["Article 2", "Article1"], articles.map(&:title)
    assert_equal ["", "John Doe"], articles.map(&:author)
    assert_equal ["Lorem ipsum" * 3, "Lorem ipsum" * 2], articles.map(&:body)
    assert_equal [0, 2], articles.map(&:likes)
    assert_equal [0, 0], articles.map(&:dislikes)
  end
end

class WebPageTest < Minitest::Test
  def setup
    @dir = Dir.mktmpdir
    @webpage = WebPage.new(@dir)

    @article1 = Article.new("foo", "bar", "foobar")
    @article1.likes = 3
    @article1.dislikes = 2
    @article2 = Article.new("fooo", "barr", "foobarr")
    @article2.likes = 4
    @article2.dislikes = 2
  end

  def test_new_without_anything_to_load
    assert_equal [], @webpage.articles
  end

  def test_new_article
    size_before = @webpage.articles.size
    @webpage.new_article("foo", "bar", "foobar")

    assert_equal size_before + 1, @webpage.articles.size
  end

  def test_longest_articles
    @webpage.instance_variable_set(:@articles, [@article1, @article2])
    articles = @webpage.longest_articles

    assert articles[0].length >= articles[1].length
  end

  def test_best_articles
    @webpage.instance_variable_set(:@articles, [@article1, @article2])
    articles = @webpage.best_articles

    assert articles[0].points >= articles[1].points
  end

  def test_best_article
    @webpage.instance_variable_set(:@articles, [@article1, @article2])

    assert_equal @article2, @webpage.best_article
  end

  def test_best_article_exception_when_no_articles_can_be_found
    assert_raises(WebPage::NoArticlesFound) { @webpage.best_article }
  end

  def test_worst_articles
    @webpage.instance_variable_set(:@articles, [@article1, @article2])
    articles = @webpage.worst_articles

    assert articles[0].points <= articles[1].points
  end

  def test_worst_article
    @webpage.instance_variable_set(:@articles, [@article1, @article2])

    assert_equal @article1, @webpage.worst_article
  end

  def test_worst_article_exception_when_no_articles_can_be_found
    assert_raises(WebPage::NoArticlesFound) { @webpage.worst_article }
  end

  def test_most_controversial_articles
    @webpage.instance_variable_set(:@articles, [@article1, @article2])
    articles = @webpage.most_controversial_articles

    assert articles[0].votes >= articles[1].votes
  end

  def test_votes
    @webpage.instance_variable_set(:@articles, [@article1, @article2])

    assert_equal 11, @webpage.votes
  end

  def test_authors
    @article3 = Article.new("bar", "foo", "foobar")
    @webpage.instance_variable_set(:@articles, [@article1, @article2, @article3])

    assert_equal %w(foobar foobarr), @webpage.authors
  end

  def test_authors_statistics
    @article3 = Article.new("bar", "foo", "foobar")
    @webpage.instance_variable_set(:@articles, [@article1, @article2, @article3])

    assert_equal 2, @webpage.authors_statistics["foobar"]
    assert_equal 1, @webpage.authors_statistics["foobarr"]
  end

  def test_best_author
    @article3 = Article.new("bar", "foo", "foobar")
    @webpage.instance_variable_set(:@articles, [@article1, @article2, @article3])

    assert_equal "foobar", @webpage.best_author
  end

  def test_search
    @webpage.instance_variable_set(:@articles, [@article1, @article2])

    assert_equal 2, @webpage.search(/[a,b]{2}r/).size
    assert_equal 1, @webpage.search("rr").size
    assert @webpage.search("abc").empty?
  end
end
