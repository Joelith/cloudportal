# Cloud Portal

Cloud Portal uses the Fog cloud abstraction library to provide a simple interface to any fog-compliant cloud. It provides a mechanism to administrators to create configurations of cloud components that users can then request for provisioning, thereby hiding the complexity of understanding the cloud and how it's configured. 

This is a work in progress and still has large capability gaps (in particular security hasn't been implemented!). Consider this a reference example on what can be achieved with Fog. 

## Installation

Download this git file and install somewhere. (You will need Rails 5 already installed). 

You will need to install a plugin for one of the clouds. Only the Oracle Cloud Platform is supported at the moment. The current code already includes this in the gemfile, so it's already installed. (It will be removed at some point). 

Run bundle to install everything

  $ bundle install

Run the database migrations:

  $ rails db:migrate
  
Add the following configuration to config/app_config.yml (assumming we are using the Oracle Cloud plugin. See the individual plugins for more details)
```yaml
---
defaults: &defaults
  oracle_username: <username>
  oracle_password: <password>
  oracle_domain: <identity domain>
  oracle_compute_api: <compute api>
  oracle_region: <region, remove for us data centre>
  oracle_storage_api: <storage api>
  plugins: 
    oraclecloud: 
      - name: Database
        class: CpOraclecloud::DatabaseComponent
      - name: WebLogic
        class: CpOraclecloud::JavaComponent

development:
  <<: *defaults

test:
  <<: *defaults

production:
  <<: *defaults


```

The 'plugins' section defines which Cloud Providers you support and what components from them you are using. 
