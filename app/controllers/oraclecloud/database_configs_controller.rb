module Oraclecloud
	def self.table_name_prefix
    'oraclecloud_'
  end

	class DatabaseConfigsController < ApplicationController
		before_action :set_product
		before_action :set_database_config, only: [:show, :edit, :update, :destroy]

	  prepend_view_path 'app/views/oraclecloud'

	 	def new
			@database_config = Oraclecloud::DatabaseConfig.new
		end

		def show
		end

		def create
		  @database_config = Oraclecloud::DatabaseConfig.new(database_config_params)
		  @database_config.product = @product

		  if @database_config.save
		    flash[:notice] = "Database Config has been created."
				redirect_to [@product, @database_config]
		  else
	  	  flash.now[:alert] = "Database Config has not been created."
		    render "new"
		  end
		end

		def edit
		end

		def destroy
			@database_config.destroy
	  	flash[:notice] = "Database Config has been deleted."

	  	redirect_to product_path
		end

		def update
			if @database_config.update_attributes(database_config_params)
				flash[:notice] = "Database Config has been updated."
				redirect_to [@product, @database_config]
			else
				flash.now[:alert] = "Database Config has not been updated."
				render "edit"
			end
		end

		private

		def set_product
			@product = Product.find(params[:product_id])
		end

		def set_database_config
		  @database_config = Oraclecloud::DatabaseConfig.find(params[:id])
		rescue ActiveRecord::RecordNotFound
		  flash[:alert] = "The database config you were looking for could not be found."
		  redirect_to product_path
		end

		def database_config_params
	  	params.require(:oraclecloud_database_config).permit(:service_name, :description, :edition, :shape, :version, :level, :subscription_type, :ssh_key )
		end
	end
end
