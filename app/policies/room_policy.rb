class RoomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    # only one room by user
    user.rooms.count <= 1
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def tickets?
    true
  end
end
