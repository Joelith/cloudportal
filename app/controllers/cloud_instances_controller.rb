class CloudInstancesController < ApplicationController
	before_action :set_instance, only: [:show, :destroy, :edit, :update]
	before_action :set_breadcrumb, only: :show

	def show
		authorize @instance
	end

	def errors
		authorize CloudInstance
		@instances = CloudInstance.select { |i| i.status != 'PROVISIONED' }.group_by(&:environment)
	end

	def update
		authorize @instance
		if @instance.update_attributes(instance_params)
			flash[:notice] = "Instance has been updated."
			redirect_to errors_cloud_instances_path
		else
			flash.now[:alert] = "Instance has not been updated."
			render "edit"
		end
	end


	def edit
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

	def instance_params
  	params.require(:cloud_instance).permit(:init_config)
	end

end
