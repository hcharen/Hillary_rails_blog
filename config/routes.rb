Rails.application.routes.draw do
  get 'profiles/show'

  devise_for :users, :controllers => { registrations: 'registrations' }
# set up homepage to root to welcome#index
  get 'posts/index'
# used to declare a standard REST resource

  resources :posts do
    resources :comments # nested resources within posts
  end
  resources :users
  root 'posts#index'

  # ':user_name' is a dynamic parameter, meaning we can pass in diffferent user_names's
  get ':user_name', to: 'profiles#show', as: :profile

  # ditto.
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile

  patch ':user_name/edit', to: 'profiles#update', as: :update_profile

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
