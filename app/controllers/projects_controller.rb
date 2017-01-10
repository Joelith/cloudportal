class ProjectsController < ApplicationController
	before_action :set_project, only: [:show, :edit, :update, :destroy]

	def index
		authorize Project
		@projects = policy_scope(Project)
  end

 	def new
		authorize Project
		@project = Project.new
	end

	def show
		authorize @project
	end

	def create
		authorize Project
	  @project = Project.new(project_params)

	  if @project.save
	  	@project.users << current_user
	    flash[:notice] = "Project has been created."
	    redirect_to @project
	  else
  	  flash.now[:alert] = "Project has not been created."
	    render "new"
	  end
	end

	def edit
		authorize @project
	end

	def destroy
		authorize @project
		@project.destroy
  	flash[:notice] = "Project has been deleted."

  	redirect_to projects_path
	end

	def update
		authorize @project
		if @project.update_attributes(project_params)
			flash[:notice] = "Project has been updated."
			redirect_to @project
		else
			flash.now[:alert] = "Project has not been updated."
			render "edit"
		end
	end

	def select_team
		@project = Project.find(params[:project_id])

		respond_to do |format|
	    format.html
	    format.js
	  end
	end	

	private

	def set_project
	  @project = Project.find(params[:id])
	rescue ActiveRecord::RecordNotFound
	  flash[:alert] = "The project you were looking for could not be found."
	  redirect_to project_path
	end

	def project_params
  	params.require(:project).permit(:name, :budget, :description, :user_ids=>[])
	end
 end
