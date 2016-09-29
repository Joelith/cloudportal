class Project < ApplicationRecord
		has_many :environments

	  validates :name, :presence => true
	  validates :budget, :presence => true

end
