class Environment < ApplicationRecord
  belongs_to :product
  belongs_to :project
  has_many :cloud_instances, :dependent => :destroy

  validates :name, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :product, :presence => true

	validate :start_date_cannot_be_in_the_past, :on => :create
	validate :end_date_cannot_be_in_the_past
	validate :end_date_greater_than_start_date

  after_create :add_instances, on: :create
  after_commit :build_instances, on: :create


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

	def total_expenditure
		cost = 0
		#logger.debug "Calc expenditure for #{start_date} - #{Date.today}"
		if Rails.env.development? then _end = start_date + 20.days else _end = Date.today end
		if _end > end_date 
			# The instance should have been turned off.
			# For the moment assume it has stopped. Need to think this through!
			_end = end_date
		end
		if (start_date < _end)
			cloud_instances.each do |ins|
				cost += ins.calc_cost(start_date, _end)
			end
		end
		cost
	end

	def expiring?
		if end_date > Time.now and end_date - 30.days <= Time.now
			true
		else 
			false 
		end
	end

	def expire
		if end_date < Time.now
			cloud_instances.map{ |i| i.deprovision }
		end
	end

	def self.expire_environments
		Environment.joins(:cloud_instances).where("DATE(end_date) <= :now AND status = 'PROVISIONED'", now: Date.today).each do |env|
			env.expire
		end
	end

  protected
  def add_instances
		# Grab the components to build from the product
		# and then attach them to here
		product.cloud_components.each do |comp|
			cleaned_config = clean_config(comp.config)
			instance = cloud_instances.create({
				:name => cleaned_config[comp.instance_name],
				:type => comp.instance_type,
				:init_config => cleaned_config,
				:status => 'PENDING'
			})
		end  	
  end

  def build_instances
  	if Rails.env.development?
  		CloudProvisionerJob.perform_later(cloud_instances.pluck(:id))
 	 	else
  		CloudProvisionerJob.set(wait_until: start_date.at_beginning_of_day).perform_later(cloud_instances.pluck(:id))
  	end
  end

  def clean_hash(h, replacements) 
  	h.each_pair do |k,v|
	    if v.is_a?(Hash)
	      clean_hash(v, replacements)
	    else
	      h[k] = replacements.inject(v) do |str, (k,v) |
	      	if str.is_a? String then str.gsub(k,v) end
	      end
	    end
	  end
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
		clean_config = config.clone
		clean_hash(clean_config, @replacements)
  	clean_config
  end


  
end
