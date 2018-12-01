class User < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    puts auth
    create! do |u|
      u.email = auth.info.name
      u.token = auth.credentials.token
    end
  end
end


