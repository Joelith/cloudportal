class CloudInstancePolicy < ApplicationPolicy

	def create?
		true
  end

  def index?
  	true
  end

  def edit?
		user.has_role? :admin
	end

	def update?
		user.has_role? :admin
	end

	def destroy?
		true
	end

	def errors?
		user.has_role? :admin
	end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
