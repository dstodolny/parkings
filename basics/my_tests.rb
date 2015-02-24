require 'minitest/autorun'
require './example'

class ArticleTest < Minitest::Test
  def setup
    @article = Article.new("foo", "bar", "baz")
  end

  def test_initialization
    assert_equal "foo", @article.title
    assert_equal "bar", @article.body
    assert_equal "baz", @article.author
    assert_equal 0, @article.likes
    assert_equal 0, @article.dislikes
    assert_equal Time, @article.created_at.class
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
