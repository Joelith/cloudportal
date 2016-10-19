class Environment < ApplicationRecord
  belongs_to :product
  belongs_to :project
  has_many :cloud_instances, :dependent => :destroy

  validates :name, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :product, :presence => true

	validate :start_date_cannot_be_in_the_past
	validate :end_date_cannot_be_in_the_past
	validate :end_date_greater_than_start_date

  after_create :add_instances, on: :create

	def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end

	def end_date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end

  def end_date_greater_than_start_date
    if end_date.present? && start_date.present? && start_date > end_date
      errors.add(:end_date, "can't be earlier than start date")
    end
  end
  
  
	def total_cost
		cost = 0
		cloud_instances.each do |ins|
			cost += ins.calc_cost(start_date, end_date)
		end
		cost
	end

  protected
  def add_instances
		# Grab the components to build from the product
		# and then attach them to here
		product.cloud_components.each do |comp|

			if comp.provider && comp.fog_type then
				cleaned_config = clean_config(comp.config)
				instance = cloud_instances.create({
					:name => cleaned_config[comp.instance_name],
					:type => comp.instance_type,
					:init_config => cleaned_config,
					:status => 'PENDING'
				})
			#	instance.save
			end 
		end  	
		CloudProvisionerJob.perform_later(cloud_instances.pluck(:id))
  end

  def clean_config(config)
		@replacements ||= [
			["%PROJ%", project.name],
			["%PROJ_4%", project.name[0..3]],
			["%PROJ_8%", project.name[0..7]],
			["%ENV%", name],
			["%ENV_4%", name[0..3]],
			["%ENV_8%", name[0..7]]
		]
		clean_config = {}
  	config.each do |key, value|
  		clean_config[key] = @replacements.inject(value) { |str, (k,v)| if str.is_a? String then str.gsub(k,v) end }
  	end
  	clean_config
  end


  
end
