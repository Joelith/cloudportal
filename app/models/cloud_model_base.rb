class CloudModelBase
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  # declare attributes in subclass with attr_accessor
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def self.compute
    @compute ||= Fog::Compute.new(
      :provider => 'OracleCloud',
      :oracle_username => APP_CONFIG[:oracle_username],
      :oracle_password => APP_CONFIG[:oracle_password],
      :oracle_domain => APP_CONFIG[:oracle_domain],
      :oracle_compute_api => APP_CONFIG[:oracle_compute_api]
      )
  end
end