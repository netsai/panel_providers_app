class TargetGroup < ActiveRecord::Base

  validates_presence_of :name, :presence => true
  belongs_to :panel_provider, :dependent => :destroy
  has_many :country_target_groups
  belongs_to :parent, :class_name => 'TargetGroup'
  has_many :children, :class_name => 'TargetGroup', :foreign_key => 'parent_id'


  scope :top_level, where(:parent_id => nil)
  #attr_accessor :name

  def self.target_groups(country_ids)
    target_groups = ActiveRecord::Base.connection.select_all("select name from (
                    WITH RECURSIVE target_groups_tree(id, name, path) AS (
                      SELECT id, name, ARRAY[id]
                      FROM target_groups
                      WHERE parent_id IS NULL
                    UNION ALL
                      SELECT target_groups.id, target_groups.name, path || target_groups.id
                      FROM target_groups_tree
                      JOIN target_groups ON target_groups.parent_id=target_groups_tree.id
                      WHERE NOT target_groups.id = ANY(path)
                    )
                    SELECT * FROM target_groups_tree ORDER BY path) as d
                     WHERE  path @> '{#{country_ids.join(',')}}'::integer[]  order by id asc;")
    return target_groups
  end

  def descendents
    self_and_descendents - [self]
  end

  def self_and_descendents
    self.class.tree_for(self)
  end

  def descendent_pictures
    subtree = self.class.tree_sql_for(self)
    CountryTargetGroup.where("target_group_id IN (#{subtree})")
  end

  def self.tree_for(instance)
    where("#{table_name}.id IN (#{tree_sql_for(instance)})").order("#{table_name}.id")
  end

  def self.tree_sql_for(instance)
    tree_sql =  <<-SQL
      WITH RECURSIVE search_tree(id, path) AS (
          SELECT id, ARRAY[id]
          FROM #{table_name}
          WHERE id = #{instance.id}
        UNION ALL
          SELECT #{table_name}.id, path || #{table_name}.id
          FROM search_tree
          JOIN #{table_name} ON #{table_name}.parent_id = search_tree.id
          WHERE NOT #{table_name}.id = ANY(path)
      )
      SELECT id FROM search_tree ORDER BY path
    SQL
  end

end
