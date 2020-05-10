Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'is-sign-in', action: :sign_in?, controller: 'tshr'
  post 'sign-in', action: :sign_in, controller: 'tshr'
end
