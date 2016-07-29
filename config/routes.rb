Rails.application.routes.draw do

  resources :users, only: [:new, :create, :edit, :update, :destroy]

  scope module: 'users' do
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :password_changes, only: [:edit, :update]
    resources :account_verifications, only: [:new, :create, :edit]
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :organizations do
    resources :claim_requests
  end

  # ajax action for organization filter on directory page
  post "/organizations/filter" => "organizations#filter"

  resources :news, only: [:index]
  get "/news/search_news" => "news#search_news"
  resources :news_filters, only: [:create, :destroy]

  # resources :technologies, only: [:create, :destroy]


  resources :events

  get "/about"                => "home#about"


  namespace :admin do
    get "/organizations"  => "admin#organizations"

    resources :organizations do
      resources :claim_requests
    end

    get "/events"         => "admin#events"

    get "/users"          => "admin#users"

    resources :users, only: [:new, :create, :edit, :update, :destroy]

    get "/technologies"   => "admin#technologies"

    resources :technologies, only: [:create, :destroy]

  end

  root "organizations#index"
end
