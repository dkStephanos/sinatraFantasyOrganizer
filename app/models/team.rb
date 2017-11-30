class Team < ActiveRecord::Base
  belongs_to :user

  def slug
    self.name.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    Team.all.each do |team|
      if(team.slug == slug)
        return team.first
      end
    end
  end
end
