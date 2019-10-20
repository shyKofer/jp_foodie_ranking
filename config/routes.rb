Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # /api/restaurants/v1/references/tabelog
  namespace :api do
    namespace :restaurants do
      namespace :v1 do
        namespace :references do
          resources :tabelog
        end
      end
    end
  end

    # /api/collectors/v1/batch/tabelog
  namespace :api do
    namespace :collectors do
      namespace :v1 do
        namespace :batch do
          resources :tabelog
        end
      end
    end
  end

end
