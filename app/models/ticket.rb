class Ticket < ApplicationRecord
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id', optional: true
  belongs_to :room

  validates :description, presence: true


end
