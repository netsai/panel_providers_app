class CountryTargetGroup < ActiveRecord::Base

  belongs_to :country
  belongs_to :target_group

  def self.descendents_of(target_group)
    joins("INNER JOIN (#{TargetGroupt.tree_sql_for(target_group)}) tree ON #{table_name}.category_id = tree.id")
  end

  def self.target_groups_of_countries(country_target_groups)
    parent_target_group_ids = [country_target_groups].map{|p|p['id']}
    TargetGroup.target_groups(parent_target_group_ids)
  end

end
