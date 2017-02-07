class UserPolicy < ApplicationPolicy

	def create?
    user.has_role? :admin && !Rails.env.development
  end

  def index?
  	user.has_role? :admin
  end

  def edit?
    user.has_role? :admin && !Rails.env.development
	end

	def update?
    user.has_role? :admin && !Rails.env.development
	end

	def destroy?
    user.has_role? :admin && !Rails.env.development
	end
	
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
