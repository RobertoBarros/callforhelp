class Room < ApplicationRecord
  belongs_to :user
  has_many :tickets
  has_many :teachers
  has_many :users, through: :teachers

  validates :name, presence: true, uniqueness: true
end
