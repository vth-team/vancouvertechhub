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
    # get "/organizations"  => "admin#organizations",
    #                             as: :organizations
    resources :organizations do
      resources :claim_requests
    end

  get "/admin/events"         => "admin#events",
                              as: :admin_events

  get "/admin/users"          => "admin#users",
                              as: :admin_users

  post "/admin/users"         => "admin#users"

    get "/technologies"   => "admin#technologies",
                                as: :technologies

    resources :technologies, only: [:create, :destroy]

  end


  root "organizations#index"
end
