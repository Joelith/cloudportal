class CloudInstancesController < ApplicationController
	before_action :set_project
	before_action :set_environment
	before_action :set_instance

	def show
	end

	private
	def set_project
		@project = Project.find(params[:project_id])
	end

	def set_environment
		@environment = Environment.find(params[:environment_id])
	end

	def set_instance
	  @instance = CloudInstance.find(params[:id])
	rescue ActiveRecord::RecordNotFound
	  flash[:alert] = "The instance you were looking for could not be found."
	  redirect_to project_path
	end

end
