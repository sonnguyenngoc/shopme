Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  
  # account
  get "account/login" => "account#login", as: :login
  get "account/forgotten" => "account#forgotten", as: :forgotten
  get "account/my_account" => "account#my_account", as: :my_account
  get "account/wishlist" => "account#wishlist", as: :wishlist
  get "account/register" => "account#register", as: :register
  get "account/order" => "account#order", as: :order
  get "account/address" => "account#address", as: :address
  # end account
  
  # checkout
  get "checkout/cart" => "checkout#cart", as: :cart
  get "checkout/checkout" => "checkout#checkout", as: :checkout
  # end checkout
  
  # blog
  get "blog" => "blog#index", as: :index
  get "blog/show" => "blog#show", as: :show
  # end blog
  
  # information
  get "information/about_us" => "information#about_us", as: :about_us
  get "information/contact_us" => "information#contact_us", as: :contact_us
  get "information/delivery" => "information#delivery", as: :delivery
  get "information/faq" => "information#faq", as: :faq
  get "information/privacy_policy" => "information#privacy_policy", as: :privacy_policy
  get "information/terms_conditions" => "information#terms_conditions", as: :terms_conditions
  get "information/sitemap" => "information#sitemap", as: :sitemap
  # end information
  
  # manufacturer
  get "manufacturer/list" => "manufacturer#list", as: :list
  get "manufaturer/products" => "manufaturer#products", as: :products
  # end manufacturer
  
  # product
  get "product/category" => "product#category", as: :category
  get "product/comparison" => "product#comparison", as: :comparison
  get "product/product" => "product#product", as: :product
  get "product/quickview" => "product#quickview", as: :quickview
  get "search/products" => "product#search", as: :search
  get "product/testimonial" => "product#testimonial", as: :testimonial
  # end product

  namespace :admin do
    get "main" => "main#index"
    resources :products
    resources :categories
    resources :manufacturers
    resources :articles
    resources :article_categories
    resources :areas
  end
end
