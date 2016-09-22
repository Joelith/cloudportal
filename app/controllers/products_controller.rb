class ProductsController < ApplicationController
	before_action :set_product, only: [:show, :edit, :update]

	def index
		@products = policy_scope(Product)
	end

	def new
		@product = Product.new
	end

	def create
	  @product = Product.new(product_params)

	  if @product.save
	    flash[:notice] = "Product has been created."
	    redirect_to @product
	  else
  	  flash.now[:alert] = "Product has not been created."
	    render "new"
	  end
	end

	def show
	end

	private

	def set_product
	  @product = Product.find(params[:id])
	rescue ActiveRecord::RecordNotFound
	  flash[:alert] = "The product you were looking for could not be found."
	  redirect_to product_path
	end

	def product_params
  	params.require(:product).permit(:name, :description)
	end
end
