class RateCardPolicy < ApplicationPolicy

  def index?
    user.has_role? :admin
  end

  def create?
    user.has_role? :admin
  end
end
