class OracleCloudDatabase < CloudInstance

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
		instance = connection.instances.get(name)
		instance.status
	end

	def month_cost
		cost = 0
		if init_config['edition'] == 'EE' then
			if init_config['level'] == 'HP' then
				rc = RateCard.where("provider = ? AND key = ?", provider, 'Database Cloud Service EE HP').first
				rc ? cost = rc.value : 0
			end
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