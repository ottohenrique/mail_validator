Rails.application.routes.draw do
  root 'validator#index'

  get 'validator/index'
  get 'validator/results'
  post 'validator/validate'
end
