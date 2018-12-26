module Paper
  def self.body
    return @body if @body
    result = ""
    client.bookmarks.bookmarks.each do |bookmark|
      result += "<h1>" + bookmark.title + "</h1>"
      result += "<div class='article'>" + client.get_text(bookmark.bookmark_id) + "</div>"
    end
    @body = "<html><head></head><body>" + result + "</body></html>"
  end

  def self.pdf
    kit = PDFKit.new(body,
                     :page_size => 'Letter',
                     :margin_top => '0.5in',
                     :margin_right => '0.5in',
                     :margin_bottom => '0.5in',
                     :margin_left => '0.5in')
    kit.stylesheets << "/home/vivian/dev/downstairser/public/stylesheets/application.css"
    pdf = kit.to_pdf
    file = kit.to_file('testing.pdf')
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
