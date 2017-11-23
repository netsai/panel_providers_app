class Location < ActiveRecord::Base

  validates_presence_of :name, :presence => true

  has_many :location_location_groups
  has_many :location_groups, through: :location_location_groups

  #attr_accessor :name

  def panel_provider
    LocationGroup.find(external_id).name.to_s
  end

  def self.locations_for(country_id)
    locations = ActiveRecord::Base.connection.select_all("select locations.* ,location_groups.name as location_group
                  ,countries.country_code as country
                  from locations
                  join location_location_groups as llg on llg.location_id=locations.id
                  join location_groups on llg.location_group_id=location_groups.id
                  join countries on location_groups.country_id =countries.id
                  where countries.id = #{country_id} ")
  end

end
