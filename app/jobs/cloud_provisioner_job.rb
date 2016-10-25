class CloudProvisionerJob < ApplicationJob
  queue_as :default

  def perform(ids)
  	instances = CloudInstance.find(ids)
  	# Now provision each of the instances
    previous_error = false
  	instances.each do |instance|
  		logger.debug "Provisioning instance: #{instance.inspect}"
      if previous_error
        instance.update(status: 'SKIPPED')
        next
      end
			begin
        instance.provision
		  	instance.wait
  		  instance.update(status: 'PROVISIONED')
  		rescue ArgumentError => exception
        logger.fatal "Validation error in Job: #{exception.inspect}"
        instance.update(status: 'VALIDATION_ERROR')
        previous_error = true
      end
      logger.debug "Instance updated"
  	end
  end

  rescue_from(StandardError) do |exception|
  	logger.fatal "Exception in Job: #{exception.inspect}"
    logger.error $!.backtrace
    CloudInstance.find(self.arguments[0]).each do |instance|
      instance.update(status: 'ERROR')
    end
  end
end
