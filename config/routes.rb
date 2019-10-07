Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # /api/restaurants/v1.0/sources/tabelog
  namespace :api do
    namespace :restaurants do
      namespace :v1 do
        namespace :references do
          resources :tabelog
        end
      end
    end
  end
end
