class User < ActiveRecord::Base
  has_many :articles

  def self.create_with_omniauth(auth)
    return false unless ENV["BOARD"].split(" ").include?(auth.info.name)
    create! do |u|
      u.email = auth.info.name
      u.token = auth.credentials.token
      u.token_secret = auth.credentials.secret
    end
  end

  def sync_articles
    have = articles.pluck(:instapaper_id).join(",")
    instapaper.bookmarks().bookmarks.each do |b|
      a = Article.find_or_initialize_by(instapaper_id: b.bookmark_id)
      a.update!(
        user_id: id,
        title: b.title,
        saved_at: b.time,
        starred: b.starred,
      )
      a.sync_body
    end
  end

  def instapaper
    @instapaper ||= Instapaper::Client.new do |client|
      client.consumer_key = ENV["INSTAPAPER_CONSUMER_KEY"]
      client.consumer_secret = ENV["INSTAPAPER_CONSUMER_SECRET"]
      client.oauth_token = token
      client.oauth_token_secret = token_secret
    end
  end
end


