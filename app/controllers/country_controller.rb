class CountryController < ApplicationController

  def index
    @countries = Country.all
  end

  def list_panel_providers
    @panel_providers = PanelProvider.find_by_sql("select panel_providers.code as panel_provider
                       from panel_providers
                       join countries on countries.panel_provider_id=panel_providers.id
                       where countries.country_code='#{params['country']}' ")
    @panel_providers
  end

  def new
    @panel_providers = PanelProvider.all.map { |p| [p.code, p.id.to_i] }
  end

  def create
    @country = Country.new(params[:country])
    if @country.save
      flash[:notice] = 'new record created successfully'
      #render :action => 'edit'
      render :inline => %{
         <script>
          window.close();
          window.opener.location.reload(true);
        </script>}
    else
      flash[:alert] = "Country could not be added"
      render :action => 'new'
    end
  end

  def edit
    id = params[:id]
    if id && @country = Country.find(id)
      @panel_providers = []
      render :action => 'edit'
    end
  end

  def delete
    id = params[:id]
    if id && country = Country.find(id)
      country.destroy
      session[:alert] = ' Record deleted.'
      render :action => 'index'
    end
  end

  def update
    id = params[:country][:id]
    if id && @country = Country.find(id)
      if @country.update_attributes(params[:country])
        flash[:notice] = 'record saved'
        render :action => 'index'
      else
        render :action => 'edit'
      end
    end
  end

end
