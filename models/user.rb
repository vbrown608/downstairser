class User < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    puts auth
    create! do |u|
      u.email = auth.uid
      u.token = auth.credentials.token
    end
  end
end


