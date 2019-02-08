# == Route Map
#
#                    Prefix Verb URI Pattern                                                                              Controller#Action
#        rails_service_blob GET  /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET  /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET  /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT  /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  
  devise_for :users, controllers: { omniauth_callbacks: "auth/omniauth_callbacks",registrations: "auth/registrations"},
              path: '', path_names: { sign_in: 'login',
                                      sign_out: 'logout',
                                      sign_up: 'register' }

  
  authenticated :user do
    root to: "home#index"
     mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end

  root to: "main#index"
  resources :main, only: [:index, :new, :create]
  resources :posts do
    collection do
      get :found
      get :lost
    end
    resources :comments, except: [:index, :new, :show] do
      member do
        get :reply
      end
    end
  end
  get 'regions', to: 'regions#regions_provinces', as: 'regions'
  get 'provinces/:province_id', to: 'regions#regions_provinces_districts', as: 'provinces_districts'
  match '*unmatched_route', to: 'application#routing', via: [:all]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
