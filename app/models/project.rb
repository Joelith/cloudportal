class Project < ApplicationRecord
	has_many :environments, :dependent => :destroy
	has_and_belongs_to_many :users

  validates :name, :presence => true
  validates :budget, :presence => true
  validates_numericality_of :budget

	def current_spend 
		cost = 0
		environments.each do |env|
			cost += env.total_expenditure
		end
		cost
	end

	def spend_against_budget 
		current_spend / budget * 100
	end	
end
