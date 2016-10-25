Rails.application.routes.draw do
	#mount CpOraclecloud::Engine, at: "/oraclecloud"

  get 'environments/index'

  devise_for :users
  authenticated :user do
	  root "projects#index", as: :authenticated_root
	end
	root to: redirect('/users/sign_in')
	
	resources :products do
		resources :cloud_components
		#namespace :oraclecloud do
		#	resources :database_components, type: 'Oraclecloud::DatabaseComponent'
		#end
	end

	resources :projects do
		resources :environments do
			resources :cloud_instances
			#namespace :oraclecloud do
			#	resources :database_instances, type: 'Oraclecloud::DatabaseInstance' do
			#		put :backup
			#	end
			#end
			#resources :oracle_cloud_database, controller: 'cloud_instances', type: 'OracleCloudDatabase'
		end
	end
	resources :cloud_components do
		post :update_position, on: :collection
	end

	#namespace :oraclecloud do
	#	resources :database_instances, type: 'Oraclecloud::DatabaseInstance' do
	#		put :backup
	#	end
	#end

	#namespace :oraclecloud do
	#	resources :databases do
	#		put :backup
	#	end
	#end

	resources :rate_cards


end