module ActionDispatch::Routing
  class Mapper
    def admin_auth_routes
      namespace :admin do
        get '/login', to: 'sessions#new'
        post '/login', to: 'sessions#create'
        get '/logout', to: 'sessions#destroy'

        resources :admins

        root 'sessions#new'
      end
    end
  end
end
