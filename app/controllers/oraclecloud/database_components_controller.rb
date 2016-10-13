module Oraclecloud
	class DatabaseComponentsController < CloudComponentsController

		private
		def component_params
		  params.require(:oraclecloud_database_component).permit(:service_name, :version, :description, :ssh_key, :shape, :level, :subscription_type, :edition, :backup_destination, :admin_password)
		end
	end
end