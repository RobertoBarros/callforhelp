class RoomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def index?
    user.admin?
  end

  def show?
    true
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? && record.user == user
  end

  def destroy?
    user.admin? && record.user == user
  end
end
