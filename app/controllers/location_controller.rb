class LocationController < ApplicationController
  def index
  end

  def countries
    @countries = Country.all.map { |p| [p.country_code, p.id] } #[]
    @locations = []
    @panel_providers = PanelProvider.all.map { |p| [p.code, p.id] }
  end

  def add_countries
    @countries = PanelProvider.find(params[:panel_provider_id]).countries
    respond_to do |format|
      format.json {
        render json: {countries: @countries}
      }
    end
  end

  def list_locations
    @locations = Location.all
  end

  def add_target_groups
    @country=Country.find(params['country_id'])
    target_groups = CountryTargetGroup.target_groups_of_countries(country_target_groups)
    @target_groups = target_groups.as_json #get_target_groups("where c.id='#{params['country_id']}' and tg.panel_provider_id=c.panel_provider_id")
    respond_to do |format|
      format.json {
        render json: {target_groups: @target_groups}
      }
    end

  end

  def add_locations
    @country=Country.find(params['country_id'])
    locations = Location.locations_for(params['country_id'])
    @locations = locations.as_json
    respond_to do |format|
      format.json {
        render json: {locations: @locations}
      }
    end
  end

  def list_country_location
    get_locations("where  countries.country_code='#{params['country']}'")
    render :template => "location/list_locations"
  end


end
