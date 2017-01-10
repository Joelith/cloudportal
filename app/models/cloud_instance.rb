class CloudInstance < ApplicationRecord
	belongs_to :environment
  serialize :init_config

  #after_create :provision_instance, on: :create
  def to_s
    name
  end

  def cost
  	cost = 0
  	cost
  end

  def init_config=(value)
    if value.is_a? String
      value = JSON.parse(value.gsub("'",'"').gsub('=>',':'))
    end
    super(value)
  end

  def deprovision
    self.update(status: 'DEPROVISIONED')
    _deprovision
  end

  def provision
    self.update(status: 'PROVISIONING')
    _provision
    wait
    self.update(status: 'PROVISIONED')
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
