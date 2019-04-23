module Paper
  def self.body
    result = ""
    Article.for_print.each do |article|
      result += "<h1>" + article.title + "</h1>"
      result += "<div class='article'>" + article.body + "</div>"
    end
    @body = result
  end
end
