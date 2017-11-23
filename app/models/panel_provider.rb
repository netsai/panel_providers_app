class PanelProvider < ActiveRecord::Base

  validates_presence_of :code, :presence => true
  attr_accessor :country_code, :name ,:location_id ,:country_id ,:target_group_id

  has_many :countries
  has_many :target_groups
  has_many :location_groups

  validates_presence_of     :location_id ,:country_id ,:target_group_id




end
