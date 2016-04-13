class User < ActiveRecord::Base

  has_secure_password
  has_many :posts

  def self.is_logged_in?(session)
    !!session[:user_id]
  end

  def self.current_user(session)
    user = User.find(session[:user_id])
    user
  end

  def slug
    slug = self.username.split(" ").join("-")
    slug
  end

  def self.find_by_slug(slug)
    username = slug.split("-").join(" ")
    user = self.find_by(username:username)
    user
  end

end