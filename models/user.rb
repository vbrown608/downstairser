class User < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    return false unless ENV["BOARD"].split(" ").include?(auth.info.name)
    create! do |u|
      u.email = auth.info.name
      u.token = auth.credentials.token
      u.token_secret = auth.credentials.secret
    end
  end

  def articles
    starred = instapaper
      .bookmarks(limit: 3, folder_id: :starred).bookmarks
      .select{ |x| x.time >= Paper.cutoff }
    return starred if starred.count == 3
    starred + instapaper
      .bookmarks(limit: 3 - starred.count).bookmarks
      .select{ |x| x.time >= Paper.cutoff }
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


