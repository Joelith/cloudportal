class CloudProvisionerJob < ApplicationJob
  queue_as :default

  def perform(ids)
  	instances = CloudInstance.find(ids)
  	# Now provision each of the instances
  	instances.each do |instance|
  		logger.debug "Provisioning instance: #{instance.inspect}"
			instance.provision
			instance.wait
  		instance.update(status: 'PROVISIONED')
  		logger.debug "Instance updated"
  	end
  end

  rescue_from(StandardError) do |exception|
  	logger.fatal "Exception in Job: #{exception.inspect}"
  end
end
