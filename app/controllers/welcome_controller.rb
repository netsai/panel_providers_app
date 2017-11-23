class WelcomeController < ApplicationController

  #find.all.map{|p|p.country_code}  deprecated and replaced with pluck(:country_code)
  def index
    @countries = Country.all
    @cities = City.all
    @cities
  end

  def show
    @city = City.find_by("id = ?", params[:trip][:city_id])
  end

  def update_cities
      @cities = Country.find(params[:country_id]).cities
      respond_to do |format|
        format.json {
          render json: {cities: @cities}
        }
      end

  end

end
