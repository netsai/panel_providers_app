class LocationGroup < ActiveRecord::Base

  validates_presence_of :name, :presence => true
  belongs_to :country, :dependent => :destroy
  belongs_to :panel_provider, :dependent => :destroy

  has_many :location_location_groups
  has_many :locations, through: :location_location_groups
  #attr_accessor :name

  def country
    Country.find(country_id).country_code.to_s
  end

  def panel_provider
    PanelProvider.find(panel_provider_id).code.to_s
  end

end
