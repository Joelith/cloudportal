# Cloud Portal

Cloud Portal uses the Fog cloud abstraction library to provide a simple interface to any fog-compliant cloud. It provides a mechanism to administrators to create configurations of cloud components that users can then request for provisioning, thereby hiding the complexity of understanding the cloud and how it's configured. 

This is a work in progress and still has large capability gaps (in particular security hasn't been implemented!). Consider this a reference example on what can be achieved with Fog. 

## Installation

Download this git file and install somewhere. (You will need Rails 5 already installed). 

You will need to install a plugin for one of the clouds. Only the Oracle Cloud Platform is supported at the moment. The current code already includes this in the gemfile, so it's already installed.  

Run bundle to install everything

  $ bundle install

Run the database migrations:

  $ rails db:migrate
  
The application has authentication through Pundit and Devise already configured. There are some default users confitured in seeds.db. Run the following to add them in:

  $ rails db:seed
  
You need to advise the application on which plugins you are using. To do so, add the following configuration to config/app_config.yml (assumming we are using the Oracle Cloud plugin. See the individual plugins for more details). 
```yaml
---
defaults: &defaults
  plugins: 
    - cp_oraclecloud: 

development:
  <<: *defaults

test:
  <<: *defaults

production:
  <<: *defaults


```

The 'plugins' section defines which Cloud Providers you support. Plugin specific configuration (including usernames, urls etc) needs to be added to an initializer per plugin. See each plugin for more details. As an example the initializer (in config/initializers/cp_oraclecloud.rb) for the Oracle Cloud Platform would look like:

```ruby
CpOraclecloud.setup do |config|
  config.username = <username>
  config.password = <password>
  config.domain = <domain>
  config.region = <region, remove if using US data centres>
  config.compute_api = <compute url>
  config.storage_api = <storage url>
  config.active_components = ['Database', 'Java']
end
```

## Usage
Start the server with 

  $ rails server
  
You will need to log in to be able to interact with the system. There are 2 pre-defined users:

- admin@example.com/welcome1: This user can do everything, but importantly can create and edit product definitions
- jcooper@example.com/welcome1: This user can create projects and request environments, but can't edit product definitions

## Plugins
The currently supported plugins are:
- [Oracle Cloud Platform](http://github.com/Joelith/cp_oraclecloud)
