module Oraclecloud
	class DatabaseConfig < ApplicationRecord
		self.table_name_prefix = 'oraclecloud_'

		acts_as :cloud_config

		enum edition: [:SE, :EE, :EE_HP, :EE_EP]
		enum shape: [:oc3, :oc4, :oc5, :oc6, :oc1m, :oc2m, :oc3m, :oc4m]
		enum level: [:PAAS, :BASIC]
		enum subscription_type: [:HOURLY, :MONTHLY]

  	validates :service_name, :presence => true
  	validates :edition, :presence => true
  	validates :ssh_key, :presence => true
  	validates :shape, :presence => true
  	validates :version, :presence => true
  	validates :level, :presence => true
  	validates :subscription_type, :presence => true

  end
end