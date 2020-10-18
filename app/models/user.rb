class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  enum role: %i[role_student role_teacher]

  validates :name, :role, presence: true, on: :update

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |u|
      u.provider = auth.provider
      u.uid = auth.uid
      u.name = auth.info.name
      u.email = auth.info.email
      u.avatar_url = auth.info.image
      u.nickname = auth.info.nickname
      u.password = Devise.friendly_token[0, 20]
    end
    user
  end
end
