class City < ActiveRecord::Base

  belongs_to :country
  self.primary_key = 'id'

end
