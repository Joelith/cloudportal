class CloudProvisionerJob < ApplicationJob
  queue_as :default

  def perform(ids)
  	instances = CloudInstance.find(ids)
  	# Now provision each of the instances
  	instances.each do |instance|
			instance.provision
			instance.wait
  		instance.update(status: 'PROVISIONED')
  	end
  end
end
