
class OracleDatabaseComponent < CloudComponent

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

  def instance_name
    "service_name"
  end

  def self.create_attributes
    @attributes ||= Fog::OracleCloud[:database].instances.model.attributes.uniq.reject{|key, value| [:status, :identity_domain, :creation_time, :last_modified_time, :created_by, :sm_plugin_version, :service_uri, :num_nodes, :creation_job_id, :num_ip_reservations, :timezone, :em_url, :connect_descriptor, :connect_descriptor_with_public_ip, :apex_url, :glassfish_url, :compute_site_name, :parameters, :dbaasmonitor_url].include?(key)}
    @attributes
  end

  def form_partial_to_render
    "cloud_components/oracle/database/form"
  end

end
