class CloudComponentsController < ApplicationController
	before_action :set_product
	before_action :set_component, only: [:show, :edit, :update, :destroy]
	before_action :set_type

	def new
		@component = type_class.new()
	end

	def create
		@component = type_class.new(component_params)
		@component.product = @product
	  if @component.save
	    flash[:notice] = "Component has been added."
	    redirect_to [@product, @component]
	  else
	    flash.now[:alert] = "Component has not been added."
	    render "new"
	  end
	end

	def show
	end

	def edit
	end

	def update
		if @component.update(component_params)
	    flash[:notice] = "Component has been updated."
	    redirect_to [@product, @component]
	  else
	    flash.now[:alert] = "Component has not been updated."
	    render "edit"
	  end
	end

	def destroy
		@component.destroy
  	flash[:notice] = "Component has been deleted."

  	redirect_to @product
	end

	private

	def set_product
		@product = Product.find(params[:product_id])
	end

	def set_component
	  @component = CloudComponent.find(params[:id])
	rescue ActiveRecord::RecordNotFound
	  flash[:alert] = "The component you were looking for could not be found."
	  redirect_to product_path
	end

	def component_params
	  params.require(:cloud_component).permit(:config)
	end

	def set_type 
    @type = type 
  end

	def type 
    #CloudComponent.types.include?(params[:type]) ? params[:type] : "CloudComponent"
  	params[:type]
  end

  def type_class 
    type.constantize 
  end

end
