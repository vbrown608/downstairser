class Article < ActiveRecord::Base
  belongs_to :user

  def self.sync
    User.all.each(&:sync_articles)
  end

  def self.for_print
    # Get an array of articles for each user.
    u_articles = User.includes(:articles)
      .map{ |u| u.articles.order(starred: :desc, saved_at: :desc) }
    # Zip the arrays and take the first N.
    max_len = u_articles.map(&:length).max
    ([nil] * max_len).zip(*u_articles).flatten.compact.take(9)
  end

  def sync_body
    return if body.present?
    update_attribute(:body, user.instapaper.get_text(instapaper_id))
  end
end
