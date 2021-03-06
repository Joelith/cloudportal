class ProductsController < ApplicationController
	before_action :set_product, only: [:show, :edit, :update, :destroy]

	def index
		authorize Product
		@products = policy_scope(Product)
	end

	def new
	  authorize Product
		@product = Product.new
	end

	def create
		authorize Product
	  @product = Product.new(product_params)

	  if @product.save
	    flash[:notice] = "Product has been created."
	    redirect_to @product
	  else
  	  flash.now[:alert] = "Product has not been created."
	    render "new"
	  end
	end

	def edit
		authorize @product
	end

	def show
		authorize @product
		@plugins = Cloudportal.plugins
	end

	def destroy
		authorize @product
		@product.destroy
  	flash[:notice] = "Product has been deleted."

  	redirect_to products_path
	end

	def update
		authorize @product
		if @product.update_attributes(product_params)
			flash[:notice] = "Product has been updated."
			redirect_to @product
		else
			flash.now[:alert] = "Product has not been updated."
			render "edit"
		end
	end


	private

	def set_product
	  @product = Product.find(params[:id])
	rescue ActiveRecord::RecordNotFound
	  flash[:alert] = "The product you were looking for could not be found."
	  redirect_to product_path
	end

	def product_params
  	params.require(:product).permit(:name, :description, :icon, cloud_components_attributes: [:id, :cloud_type, :config, :_destroy])
	end
end
