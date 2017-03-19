Rottenpotatoes::Application.routes.draw do
  resources :movies do
  # map '/' to be a redirect to '/movies'
    member do
      get 'similar'
    end
  end
  root :to => redirect('/movies')
end
