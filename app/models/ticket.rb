class Ticket < ApplicationRecord
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id', optional: true
  belongs_to :room

  after_commit :broadcast_room_update

  validates :description, presence: true

  private

  def broadcast_room_update
    RoomChannel.broadcast_to(self.room, nil)
  end
end
