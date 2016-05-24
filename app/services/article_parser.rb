# service object for parsing the
class ArticleParser
  ELIPSIS_REGEX = /([^.?!;\u2026]+[.?!;\u2026]+)/
  BOUNDARY = -8
  
  def initialize(news_item)
    @news_item = news_item
  end

  def htmlTitle
    @news_item.htmlTitle
  end

  def htmlSnippet
    @news_item.htmlSnippet
  end

  def thumbnail
    @news_item.pagemap.try(:[], "cse_thumbnail").try(:first).try(:[], "src")
  end

  def link
    @news_item.link
  end

  def published_on
    # Matching '...' with regex
    # http://stackoverflow.com/questions/21357295/javascript-regex-cant-match-ellipsis
    #puts /([^.?!;\u2026]+[.?!;\u2026]+)/.match(htmlSnippet)
    # The first [0] returns the first matching group before the ... in the htmlSnippet
    # [0..-8] is from the first character to, eight characters before ...
    # ie. "Mar 2, 2016 <b>..." => "Mar 2, 2016"
    published_on_string = ELIPSIS_REGEX.match(htmlSnippet)[0][0..BOUNDARY]
    published_on_string.to_datetime rescue nil
  end

end
