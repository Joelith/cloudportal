class Product < ApplicationRecord
	has_many :cloud_components, -> { order(position: :asc) }, :dependent => :destroy
	
end
