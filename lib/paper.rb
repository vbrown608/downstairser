module Paper
  def self.body
    return @body if @body
    result = ""
    client.bookmarks.bookmarks.each do |bookmark|
      result += "<h1>" + bookmark.title + "</h1>"
      result += "<div class='article'>" + client.get_text(bookmark.bookmark_id) + "</div>"
    end
    @body = result
  end

  def self.client
    @client ||= Instapaper::Client.new do |client|
      client.consumer_key = ENV["INSTAPAPER_CONSUMER_KEY"]
      client.consumer_secret = ENV["INSTAPAPER_CONSUMER_SECRET"]
      client.oauth_token = "***REMOVED***"
      client.oauth_token_secret = "***REMOVED***"
    end
  end
end
