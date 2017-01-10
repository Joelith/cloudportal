Rails.application.routes.draw do
	#mount CpOraclecloud::Engine, at: "/oraclecloud"

  get 'environments/index'

  devise_for :users
  authenticated :user do
	  root "projects#index", as: :authenticated_root
	end
	root to: redirect('/users/sign_in')
	
	resources :users

	resources :products do
		resources :cloud_components
	end

	resources :cloud_instances do
		collection do
			get 'errors'
		end
	end

	resources :projects do
		get :select_team
		resources :environments do
			resources :cloud_instances
			get :renew
		end
	end

	#get "projects/select_team" => 'projects#select_team', :as => :select_team


	resources :environments do
		member do
			put 'reprovision'
		end
	end
	
	resources :cloud_components do
		post :update_position, on: :collection
	end

	resources :rate_cards


end
