module Paper
  def self.make
    result = ""
    client.bookmarks.bookmarks.each do |bookmark|
      result += client.get_text(bookmark.bookmark_id)
    end
    "<html><head></head><body>" + result + "</body></html>"
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
