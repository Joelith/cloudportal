class CloudComponent < ApplicationRecord
  belongs_to :product
  validates_presence_of :config
  acts_as_list scope: :product

  serialize :config


  def pretty_name
  	name = 'Undefined component'
  	name
  end

  def pretty_size
  	"Undefined"
  end

  def self.types
  	%w(OracleDatabaseComponent)
	end

	def self.create_attributes
		[]
	end

  def self.create_attributes_allowed
    {}
  end

  def form_partial_to_render
    "cloud_components_form_fields"
  end

  private
end
