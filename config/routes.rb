Rails.application.routes.draw do
  resources :cards
    get 'cards/:id/transaction/new', to: 'cards#new_transaction'
  post 'cards/:id/transaction', to: 'cards#complete_transaction'
    get 'cards/:id/transactions', to: 'cards#list_transactions'
    get 'cards/:id/transaction/:txid', to: 'cards#show_transaction'
end
