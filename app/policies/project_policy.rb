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
      if user.has_role? :admin
        scope.all
      else
        scope.joins(:users).where(projects_users: {user_id: user.id})
      end
    end
  end
end
