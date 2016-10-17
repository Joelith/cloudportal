class CloudInstance < ApplicationRecord
	belongs_to :environment
  serialize :init_config

  #after_create :provision_instance, on: :create

  def cost
  	cost = 0
  	cost
  end

	#def self.instance_classes
  #  if subclasses.empty?
  #    Dir["#{Rails.root}/app/pages/*_page.rb"].each do |file|
  #      require_dependency file
  #    end
  #  end
  #
  #    base_class.subclasses
  # end
end
