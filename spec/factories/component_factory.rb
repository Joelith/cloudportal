FactoryGirl.define do
  factory :oracle_db, class: 'CpOraclecloud::DatabaseComponent' do
    service_name "%PROJ_4%_%ENV_4%_DB"
    edition "SE"
    shape "oc3"
    level "PAAS"
    subscription_type "HOURLY"
    backup_destination "NONE"
    version "12.1"
    ssh_key "ssh-rsa sadfdsf"
    admin_password "welcome1"
  end
end