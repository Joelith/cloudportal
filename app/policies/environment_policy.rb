class EnvironmentPolicy < ApplicationPolicy

	def create?
		true
  end

  def index?
  	true
  end

  def edit?
		true
	end

	def update?
		true
	end

	def destroy?
		true
	end

	def renew?
		# Only allow renewing when the environment is expiring
    user.has_any_role? :admin, :project_owner and record.expiring?
	end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
