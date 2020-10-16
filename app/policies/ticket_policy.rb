class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    # only one ticket per student per room
    open_tickets = Ticket.where(student: user)
                         .where(solved: false)
                         .group(:room_id)
                         .having('COUNT(*) > 0')
                         .count.count

    user.role_student? && open_tickets.zero?
  end

  def destroy?
    record.student == user && record.teacher.nil? && !record.solved?
  end

  def assign_teacher?
    # only one ticket per teachers per room
    assing_tickets = Ticket.where(teacher: user)
                           .where(solved: false)
                           .group(:room_id)
                           .having('COUNT(*) > 0')
                           .count.count

    user.role_teacher? && assing_tickets.zero? && record.teacher.nil?
  end

  def cancel?
    record.teacher == user
  end

  def solved?
    record.teacher == user
  end


end
