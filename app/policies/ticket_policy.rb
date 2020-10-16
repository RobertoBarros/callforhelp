class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    # only one ticket per student per room
    open_tickets = Ticket.where(student: user).where(solved: false).count
    user.role_student? && open_tickets.zero?
  end

  def destroy?
    record.student == user && record.teacher.nil? && !record.solved?
  end

  def assign_teacher?
    user.role_teacher?
  end

  def cancel?
    record.teacher == user
  end

  def solved?
    record.teacher == user
  end


end
