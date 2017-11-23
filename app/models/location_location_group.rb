class LocationLocationGroup < ActiveRecord::Base

  attr_accessible :location_group_id, :location_id

  belongs_to :location_group
  belongs_to :location

end
