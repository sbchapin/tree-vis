class Entity < ActiveRecord::Base
  has_many :relationship_sources, class_name: "Relationship", foreign_key: "entity_source_id"
  has_many :relationship_targets, class_name: "Relationship", foreign_key: "entity_target_id"
  def relationships
    relationship_sources | relationship_targets
  end

  has_many :entity_sources, through: :relationships
  has_many :entity_targets, through: :relationships
  def entities
    entity_sources | entity_targets
  end

end
