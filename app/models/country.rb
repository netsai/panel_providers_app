class Country < ActiveRecord::Base

  validates_presence_of :country_code, :presence => true
  belongs_to :panel_provider, :dependent => :destroy
  has_many :location_groups
  has_many :country_target_groups
  has_many :cities
  #attr_accessor :country_code


end
