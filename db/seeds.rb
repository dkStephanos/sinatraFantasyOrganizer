user_info = {
  "Koi Stephanos" => {
    :password => "Security"
  }
}

user_info.each do |username, password_hash|
  u = User.new(:username => username, :password => password_hash[:password])
  u.save
end

team_info = {
  "New York Knicks" => {
    :point_guard => "Jarret Jack",
    :shooting_guard => "Courtney Lee",
    :small_forward => "Tim Hardaway Jr.",
    :power_forward => "Kristaps Porzingis",
    :center => "Enes Kanter",
    :sixth_man => "Frank Ntlikina"
  }
}

team_info.each do |name, attributes_hash|
  t = Team.new
  t.name = name
  attributes_hash.each do |attribute, value|
      t[attribute] = value
  end
  t.save
end
