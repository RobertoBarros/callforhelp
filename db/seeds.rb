require 'open-uri'

# Generate 50 fake users
url = 'https://randomuser.me/api/?nat=br&results=50&inc=email,name,picture,login'
users_data = JSON.load(open(url))

users_data['results'].each do |user_data|
  user_info = {
    name: "#{user_data['name']['first']} #{user_data['name']['last']}",
    email: user_data['email'],
    nickname: user_data['login']['username'],
    avatar_url: user_data['picture']['medium'],
    password: Devise.friendly_token[0, 20]
  }
  User.create!(user_info)
end


