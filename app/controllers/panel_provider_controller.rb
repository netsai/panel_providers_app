class  PanelProviderController < ApplicationController


  def evaluate_prices
    @countries = []
    @target_groups=[]
    @locations=[]
    @panel_providers = PanelProvider.all.map{ |p| [p.code,p.id] }
  end

  def add_countries_target_groups
    @countries = PanelProvider.find(params[:panel_provider_id]).countries
    @target_groups = PanelProvider.find(params[:panel_provider_id]).target_groups

      respond_to do |format|
        format.json  { render :json => {:countries => @countries,
                                        :target_groups => @target_groups }}

    end
  end

  def add_locations
    @country=Country.find(params['country_id'])
    locations = Location.locations_for(params['country_id'])
    @locations = locations.as_json
    respond_to do |format|
      format.json {
        render json: {locations: @locations}
      }    end
  end


  def evaluate_pricesjvkg
    @panel_provider =PanelProvider.find(params[:panel_provider_id])
    where panel_provider_id = #{params[:panel_provider_id]} " ).map{|p|[p.country_code,p.id]}
              @target_groups=[]
    @locations=[]
    @countries = []
    render :template => "panel_provider/prices"
  end


  def get_panel_price
    require 'nokogiri'
    require 'net/http'

    panel_provider =PanelProvider.find(params['panel_provider_id'])
    price = get_panel_1_price if panel_provider.code == "Panel_1"
    price = get_panel_2_price if panel_provider.code == "Panel_2"
    price = get_panel_3_price if panel_provider.code == "Panel_3"

     @price = price.to_s

    respond_to do |format|
      format.json {
        render json: {price: @price}
      }    end
  end

  def get_panel_1_price
    doc = Nokogiri::HTML(open('http://time.com'))
    text = doc.at('body').inner_text
    array_a = text.scan(/a/)
    array_a_size = array_a.length
    return array_a_size/100
  end

  def get_panel_2_price
    doc = Nokogiri::HTML(open('http://openlibrary.org/search.json?q=the+lord+of+the+rings'))
    text = doc.at('body').inner_text
    arrays_collection = text.scan(/\[([^]]+)\]/)
    price = 0
    arrays_collection.each do |ary|
      price = price + 1 if ary.length > 10
    end
    return price
  end

  def get_panel_3_price
    doc = Nokogiri::HTML(open('http://time.com'))
    nodes = []
    doc.traverse { |node| nodes << node.name unless node.name == "text" }
    return  nodes.length/100
  end



  def update_target_groups
      params
  end

  def list_location_panel_providers
    @panel_providers = PanelProvider.find_by_sql("select panel_providers.code as panel_provider
                       from panel_providers
                       join countries on countries.panel_provider_id=panel_providers.id
                       where countries.country_code='#{params['country']}' ")

    render :template => "panel_provider/list_panel_providers"

  end

  def list_location_group_panel_providers
    @panel_providers = PanelProvider.find_by_sql("select panel_providers.code as panel_provider
                       from panel_providers
                       join location_groups on location_groups.panel_provider_id =panel_providers.id
                       where location_groups.name='#{params['location_group']}' ")

    render :template => "panel_provider/list_panel_providers"

  end

  def index
    @panel_providers = PanelProvider.all
  end

  def new
  end

  def create
    @panel_provider = PanelProvider.new(params[:panel_provider])
    if @panel_provider.save
      flash[:notice] = 'new record created successfully'
      render :action => 'edit'
    else
      flash[:alert] = "Panel Provider could not be added"
      render :action => 'new'
    end
  end

  def edit
    id = params[:id]
    if id && @panel_provider = PanelProvider.find(id)
      render :action => 'edit'
    end
  end

  def delete
    id = params[:id]
    if id && panel_provider = PanelProvider.find(id)
      panel_provider.destroy
      session[:alert] = ' Record deleted.'
      render :action => 'index'
    end
  end

  def update
    id = params[:panel_provider][:id]
    if id && @panel_provider = PanelProvider.find(id)
      if @panel_provider.update_attributes(params[:panel_provider])
        flash[:notice] = 'record saved'
        render :action => 'index'
      else
        render :action => 'edit'
      end
    end
  end

end
