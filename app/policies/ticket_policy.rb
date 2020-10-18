class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    # only one ticket per room
    open_tickets = Ticket.where(student: user)
                         .where(solved: false)
                         .where(room: record.room)
                         .count

    open_tickets.zero?
  end

  def destroy?
    record.student == user && record.teacher.nil? && !record.solved?
  end

  def assign_teacher?
    # user is teacher in the room
    user_is_teacher_in_room = record.room.teachers.map(&:user).pluck(:id).include?(user.id)

    # only one ticket per teachers per room
    assing_tickets = Ticket.where(teacher: user)
                           .where(solved: false)
                           .where(room: record.room)
                           .count

    user_is_teacher_in_room &&
    assing_tickets.zero? &&
    record.teacher.nil?
  end

  def cancel?
    record.teacher == user
  end

  def solved?
    record.teacher == user
  end


end
