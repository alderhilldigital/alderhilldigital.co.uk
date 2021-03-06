Rails.application.routes.draw do




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  get 'about' => 'home#about'
  get 'contact' => 'home#contact'
  #get 'courses' => 'courses#index'
  #get 'courses/building-a-website' => 'courses#building_a_website'
  #get 'courses/getting-started-with-linux' => 'courses#getting_started_with_linux'
  #get 'courses/web-design-and-development' => 'courses#web_design_and_development'
  #get 'courses/digital-marketing' => 'courses#digital-marketing'
  post 'contact' => 'home#process_contact'
  get 'certificates' => 'certificates#index'
  post 'certificates' => 'certificates#create'

  get 'administration' => 'admin#index'
  post 'administration' => 'admin/courses#index'
  get 'administration/courses' => 'admin/courses#index', :as => :admin_courses

  get 'terms-and-conditions' => 'home#terms_and_conditions'

  get "/minecraft" => redirect("/courses/minecraft")

  resources :courses do
    member do
      post 'interest'
    end
    resources :course_dates do
      collection do
        get 'book'
      end
      member do
        post 'charge'
        get 'invoice'
        post 'send_invoice'
      end
    end
  end

  namespace :administration, :as => "admin", :module => 'admin' do

    resources :courses do
      resources :course_dates do
        member do
          get 'disable'
          get 'enable'
        end
      end
    end
    resources :bookings do
      collection do
        get 'new_charge'
        post 'charge'
      end
    end
  end

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
