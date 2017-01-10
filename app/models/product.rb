class Product < ApplicationRecord
	has_many :cloud_components, -> { order(position: :asc) }, :dependent => :destroy
	dragonfly_accessor :icon

  validates_size_of :icon, maximum: 500.kilobytes
  validates :name, :presence=>true
	def monthly_cost
		monthly_cost = 0
		cloud_components.each do |comp|
			monthly_cost += comp.calculate_monthly_cost
		end
		monthly_cost
	end
end
