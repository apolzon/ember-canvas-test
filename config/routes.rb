Rails.application.routes.draw do
  root 'projects#index'
  resources :projects do
    member do
      post :upload_files
    end
  end
end
