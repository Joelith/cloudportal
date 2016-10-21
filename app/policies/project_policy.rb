class ProjectPolicy < ApplicationPolicy

	def create?
    user.has_any_role? :admin, :project_owner
  end

  def index?
  	true
  end

  def edit?
    user.has_any_role? :admin, :project_owner
	end

	def update?
    user.has_any_role? :admin, :project_owner
	end

	def destroy?
		user.has_any_role? :admin, :project_owner
	end
	
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
