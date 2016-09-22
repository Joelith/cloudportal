class ComputeInstancesController < ApplicationController
  
  def index
  	@instances = ComputeInstance.all
  end
end
