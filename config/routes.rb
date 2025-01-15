Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root 'string_calculators#index'  # This defines the root path for your app

  # POST route for adding numbers
  post 'add', to: 'string_calculators#add'  # This sends the request to the 'add' action in the controller
end
