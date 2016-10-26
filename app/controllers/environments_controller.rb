class EnvironmentsController < ApplicationController
	before_action :set_project, except: [:reprovision]
	before_action :set_environment, only: [:show, :destroy]

	def new
		authorize Environment
		@environment = Environment.new()
	end

	def create
		authorize Environment
		@environment = @project.environments.build(environment_params)
	  if @environment.save
	    flash[:notice] = "Environment has been requested."
	    redirect_to [@project, @environment]
	  else
	    flash.now[:alert] = "Environment has not been requested."
	    render "new"
	  end
	end

	def show
		authorize @environment
	end

	def destroy
		authorize @environment
		@environment.destroy
  	flash[:notice] = "Environment has been deleted."

  	redirect_to @project
	end

	def reprovision
		instances = CloudInstance.select { |i| i.status != 'PROVISIONED' }
		instances.each { |i| i.update(:status=>'PENDING') }
		CloudProvisionerJob.perform_later(instances.pluck(:id))
		flash[:notice] = "Reprovisioning job has been requested"
		redirect_to errors_cloud_instances_path
	end

	private

	def set_project
		@project = Project.find(params[:project_id])
	end

	def set_environment
	  @environment = Environment.find(params[:id])
	rescue ActiveRecord::RecordNotFound
	  flash[:alert] = "The environment you were looking for could not be found."
	  redirect_to product_path
	end

	def environment_params
	  params.require(:environment).permit(:name, :start_date, :end_date, :description, :product_id)
	end
end
