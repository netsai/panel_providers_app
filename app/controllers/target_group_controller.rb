class TargetGroupController < ApplicationController

  def add_countries
    @countries = PanelProvider.find(params[:panel_provider_id]).countries
    respond_to do |format|
      format.json {
        render json: {countries: @countries}
      }
    end

  end

  def add_target_groups
    @country=Country.find(params['country_id'])
    country_target_groups = CountryTargetGroup.find_by_country_id(params['country_id'])
    target_groups = CountryTargetGroup.target_groups_of_countries(country_target_groups)
    @target_groups = target_groups.as_json
    respond_to do |format|
      format.json {
        render json: {target_groups: @target_groups}
      }
    end

  end

  def index
    @target_groups = TargetGroup.find_by_sql("select parent_tg.* , pp.code as panel_provider
                     from target_groups as parent_tg
                      join panel_providers as pp on parent_tg.panel_provider_id=pp.id
                      join target_groups tg on parent_tg.id=tg.id")
  end

def list_all_target_groups
    @target_groups = do_target_groups_query
    render :template => "target_group/list_target_groups"
  end

  def countries
    @countries = Country.all.map{ |p| [p.country_code,p.id] }  #[]
    @target_groups = []
    @panel_providers = PanelProvider.all.map{ |p| [p.code,p.id] }
  end

  def list_target_groups
    @target_groups =TargetGroup.all.order("id")
  end

  def new
    @parent_target_groups = TargetGroup.all.map{|p|[p.name,p.id]}
    @panel_providers = PanelProvider.all.map{|p|[p.name,p.id]}
  end

  def create
    @target_group = TargetGroup.new(params[:target_group])
    if @target_group.save
      flash[:notice] = 'new record created successfully'
      render :inline => %{
         <script>
          window.location.href="/target_group/index";
        </script>}
    else
      flash[:alert] = "TargetGroup could not be added"
      render :action => 'new'
    end
  end

  def edit
    id = params[:id]
    if id && @target_group = TargetGroup.find(id)
      render :action => 'edit'
    end
  end

  def delete
    id = params[:id]
    if id && target_group = TargetGroup.find(id)
      target_group.destroy
      session[:alert] = ' Record deleted.'
      render :action => 'index'
    end
  end

  def update
    id = params[:target_group][:id]
    if id && @target_group = TargetGroup.find(id)
      if @target_group.update_attributes(params[:target_group])
        flash[:notice] = 'record saved'
        render :action => 'index'
      else
        render :action => 'edit'
      end
    end
  end

end
