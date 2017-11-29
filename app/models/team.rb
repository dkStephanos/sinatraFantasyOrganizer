class Team < ActiveRecord::Base
  belongs_to :user

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
