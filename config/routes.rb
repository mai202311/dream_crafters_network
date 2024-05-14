Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_scope :user do
    post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
    get 'users/guest_sign_out', to: 'user/sessions#destroy', as: 'delete_guest_user'

  end

  devise_for :users, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  root to: 'user/homes#top'
  get 'users/mypage' => 'user/users#show', as: "mypage"
  get 'users/search' => 'user/searches#search' #キーワード検索機能
  #カテゴリーに関するページ
  get 'posts/dreams' => 'user/posts#dreams'
  get 'posts/meisekimu' => 'user/posts#meisekimu'
  get 'posts/sleeps' => 'user/posts#sleeps'
  get 'posts/others' => 'user/posts#others'

  scope module: :user do
    resources :posts do
      member do
        get :draft
      end
    resources :post_comments, only: [:create, :destroy]  #post_commentsコントローラへのルーティング
    resources :likes, only: [ :create, :destroy]
    end
    resources :users, only: [:edit, :update]
    #resources :tags,except: [:new, :show]
  end

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
        get '/' => 'homes#top'
  end
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

