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

  resources :technologies


  resources :events

  get "/about"                => "home#about"

  get "/admin/organizations"  => "admin#organizations",
                              as: :admin_organizations

  get "/admin/events"         => "admin#events",
                              as: :admin_events

  get "/admin/users"          => "admin#users",
                              as: :admin_users

  post "/admin/users"         => "admin#users"

  get "/admin/technologies"   => "admin#technologies",
                              as: :admin_technologies
  get "/admin/news_filters"   => "admin#news_filters",
                              as: :admin_news_filters


  root "organizations#index"
end
