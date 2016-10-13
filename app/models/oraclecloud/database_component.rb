module Oraclecloud
  class DatabaseComponent < CloudComponent
    store :config, accessors: [:service_name, :version, :description, :ssh_key, :shape, :level, :subscription_type, :edition, :backup_destination, :admin_password], coder: JSON

    enum edition: [:SE, :EE, :EE_HP, :EE_EP]
    enum shape: [:oc3, :oc4, :oc5, :oc6, :oc1m, :oc2m, :oc3m, :oc4m]
    enum level: [:PAAS, :BASIC]
    enum subscription_type: [:HOURLY, :MONTHLY]
    enum backup_destination: [:NONE, :OSS, :BOTH]

    validates :service_name, :presence => true
    validates :edition, :presence => true
    validates :ssh_key, :presence => true
    validates :shape, :presence => true
    validates :version, :presence => true
    validates :level, :presence => true
    validates :subscription_type, :presence => true
    validates :admin_password, :presence => true
    validates :backup_destination, :presence => true

    def pretty_type
      'Oracle Database CS'
    end

    def pretty_size
      if config && config.is_a?(Hash) && config.key?('shape')
        config['shape']
      end
    end

    # These should be constants, can't work out
    # how to access them that way though
    def provider
      "OracleCloud"
    end

    def fog_type
      "Database"
    end

    def instance_type
      "Oraclecloud::DatabaseInstance"
    end

    def instance_name
      "service_name"
    end

  end
end