class CloudProvisionerJob < ApplicationJob
  queue_as :default

  def perform(instances)
  	# Now provision each of the instances
  	instances.each do |instance|
			instance.provision
			instance.fog.wait_for { ready? }
  		instance.update(status: 'PROVISIONED')
  	end

  end
end
