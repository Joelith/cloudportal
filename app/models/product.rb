class Product < ApplicationRecord
	has_many :cloud_components
	accepts_nested_attributes_for :cloud_components,
		:allow_destroy => true,
		:reject_if => :all_blank

end
