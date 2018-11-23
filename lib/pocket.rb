require "httparty"
require "date"

module Pocket
  def self.get_articles(user)
    path = "https://getpocket.com/v3/get"
    today = Date.today
    query = {
      consumer_key: ENV["POCKET_CONSUMER_KEY"],
      access_token: user.token,
      sort: "newest",
      count: 5,
      since: (today - today.mday).to_time.to_i,
      contentType: "article",
      detailType: "complete",
      status: 0
    }
    resp = HTTParty.post(path, query: query)
    resp["list"].values.each do |article|
      next unless article["status"] == "0"
      puts get_article_text(article["resolved_url"])
      sleep 5
    end
    resp["list"]
  end

  def self.get_article_text(url)
    HTTParty.get("http://boilerpipe-web.appspot.com/extract", query: {
      url: url,
      extractor: "ArticleExtractor",
      output: "htmlFragment",
      extractImages: 4
    }).parsed_response
  end
end

