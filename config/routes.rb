Rails.application.routes.draw do

  root 'welcome#index'

  get "home" => "home#index"
  get "sign_in" => "authentication#sign_in"
  get "signed_out" => "authentication#signed_out"
  get "new_user" => "authentication#new_user"

  post "sign_in" => "authentication#login"
  post "new_user" => "authentication#register"

  get 'show' => 'welcome#show'
  get "welcome" => 'welcome#index'
  get 'welcome/update_cities'

  get "panel_provider/evaluate_prices"
  get "panel_provider/add_countries_target_groups"
  get "panel_provider/add_locations"

  post "panel_provider/get_panel_price"


  get 'location/index'
  get 'location/add_countries'
  get "countries" => 'location#countries'
  get 'location/list_country_location'
  get 'location/location_groups'
  get 'location/list_locations'
  get 'location_group/index'
  get 'location/list_country_location'
  get 'country/new'
  get 'target_group/index'
  get 'target_group/countries'
  get 'target_group/add_countries'
  get 'target_group/add_target_groups'
  get 'target_group/list_target_groups'
  get 'panel_provider/index'
  get 'panel_provider/evaluate_prices'
  get 'panel_provider/new'
  get 'panel_provider/get_prices'
  get 'panel_provider/get_panel_prices'
  get 'panel_provider/show_panel_price'
  get 'location/countries'
  get 'location/add_locations'

end
