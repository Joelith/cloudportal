CpAws.setup do |config|
  config.aws_access_key_id = "fakeId"
  config.aws_secret_access_key = "s3cr3t"
  config.region = "us-west-2"
  config.active_components = ['EC2']
  #config.rate_card = YAML.load_file(File.expand_path "../../oraclecloud_rate_card.yml", __FILE__)[Rails.env].symbolize_keys!
end