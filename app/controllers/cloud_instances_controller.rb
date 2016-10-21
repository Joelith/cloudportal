class CloudInstancesController < ApplicationController
	before_action :set_instance, only: [:show, :destroy]
	before_action :set_breadcrumb, only: :show

	def show
		authorize @instance
	end

	private
	def set_breadcrumb
		@environment = @instance.environment
		@project = @environment.project
	end

	def set_instance
	  @instance = CloudInstance.find(params[:id])
	rescue ActiveRecord::RecordNotFound
	  flash[:alert] = "The instance you were looking for could not be found."
	  redirect_to project_path
	end

end
