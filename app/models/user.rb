class User < ActiveRecord::Base
  has_secure_password
  has_many :teams

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.each do |user|
      if(user.slug == slug)
        return user
      end
    end
  end
end
