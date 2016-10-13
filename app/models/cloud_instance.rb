class CloudInstance < ApplicationRecord
	belongs_to :environment
  serialize :init_config

  after_create :provision_instance, on: :create

  def cost
  	cost = 0
  	cost
  end

end
