module Paper
  def self.body
    return @body if @body
    result = ""
    articles.each do |article|
      result += "<h1>" + article.title + "</h1>"
      result += "<div class='article'>" + client.get_text(article.bookmark_id) + "</div>"
    end
    @body = result
  end

  def self.articles
    User.all.map{ |x| x.articles }.flatten.sort { |x, y| x.time <=> y.time }
  end

  def self.cutoff
    Time.now - 30.days
  end
end
