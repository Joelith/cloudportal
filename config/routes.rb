Rails.application.routes.draw do
  get 'environments/index'

  get 'compute_instances/index'

  devise_for :users
	root "environments#index"

	resources :products
	resources :compute_instances
	resources :environments
end
