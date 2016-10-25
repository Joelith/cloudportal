FactoryGirl.define do
  factory :oracle_db, class: 'CpOraclecloud::DatabaseComponent' do
    service_name "%PROJ_4%-%ENV_4%-DB"
    edition "SE"
    shape "oc3"
    level "PAAS"
    subscription_type "HOURLY"
    backup_destination "NONE"
    version "12.1"
    ssh_key "ssh-rsa sadfdsf"
    admin_password "Welcome1$"
  end
  factory :component_java, class: 'CpOraclecloud::JavaComponent' do
  	service_name "%PROJ_4%-%ENV_4%-WLS"
  	dba_name "SYS"
  	dba_password "welcome1"
  	db_service_name "%PROJ_4%_%ENV-4%-DB"
  	shape "oc3"
  	version "12.1"
  	ssh_key "ssh-rsa sfsdf"
  	admin_username "weblogic"
  	admin_password "Welcome1$"
	end
end