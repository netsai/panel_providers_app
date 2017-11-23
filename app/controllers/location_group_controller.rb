class LocationGroupController < ApplicationController

  def index
    # @location_groups = LocationGroup.all
  end

  def new
    @countries = []
    @panel_providers = []
  end

  def create
    @location_group = LocationGroup.new(params[:location_group])
    if @location_group.save
      flash[:notice] = 'new record created successfully'
      render :action => 'edit'
    else
      flash[:alert] = "Location Group could not be added"
      render :action => 'new'
    end
  end

  def edit
    id = params[:id]
    if id && @location_group = LocationGroup.find(id)
      @countries = []
      @panel_providers = []
      render :action => 'edit'
    end
  end

  def delete
    id = params[:id]
    if id && location_group = LocationGroup.find(id)
      location_group.destroy
      session[:alert] = ' Record deleted.'
      render :action => 'index'
    end
  end

  def update
    id = params[:location_group][:id]
    if id && @location_group = LocationGroup.find(id)
      if @location_group.update_attributes(params[:location_group])
        flash[:notice] = 'record saved'
        render :action => 'index'
      else
        render :action => 'edit'
      end
    end
  end

end
