class ProductPolicy < ApplicationPolicy

	def create?
    user.has_role? :admin
  end

  def edit?
    user.has_role? :admin
  end

  def index?
  	true
  end

  def destroy?
    user.has_role? :admin
  end

  def update?
    user.has_role? :admin
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
