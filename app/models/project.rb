class Project < ApplicationRecord
		has_many :environments, :dependent => :destroy

	  validates :name, :presence => true
	  validates :budget, :presence => true

end
