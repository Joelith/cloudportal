module Oraclecloud
  class DatabaseInstance < CloudInstance

		def provision_instance
			connection.instances.create(init_config)
		end

		def provider
			"OracleCloud"
		end

		def cloud_type
			"Database"
		end

		def status 
			begin
				@instance ||= connection.instances.get(name)
				@instance.status
			rescue Fog::OracleCloud::Database::NotFound
				"Error"
			end
		end

		def fog
			@instance ||= connection.instances.get(name)
			@instance
		end

		def attr_get(attribute)
			begin
				@instance ||= connection.instances.get(name)
				@instance.attributes[attribute.to_sym]
			rescue Fog::OracleCloud::Database::NotFound
				"Error"
			end
		end

		def month_cost
			cost = 0
			if init_config['edition'] == 'EE_EP' then
					rc = RateCard.where("provider = ? AND key = ?", provider, 'Database Cloud Service Enterprise Edition Extreme Performance').first
					rc ? cost = rc.value : 0
			end
			cost
		end

		def calc_cost(start_date, end_date)
			cost = 0
			cost = (end_date - start_date) * (month_cost / 30)
			cost
		end

		def connection 
	 		@connection ||= Fog::OracleCloud::Database.new(
	      :oracle_username => APP_CONFIG[:oracle_username],
	      :oracle_password => APP_CONFIG[:oracle_password],
	      :oracle_domain => APP_CONFIG[:oracle_domain],
	      )
		end

	end
end