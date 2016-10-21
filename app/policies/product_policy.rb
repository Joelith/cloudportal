class ProductPolicy < ApplicationPolicy

	def create?
    user.has_role? :admin
  end

  def index?
  	true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
