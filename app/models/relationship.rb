class Relationship < ActiveRecord::Base
  belongs_to :entity_source, class_name: "Entity", foreign_key: "entity_source_id"
  belongs_to :entity_target, class_name: "Entity", foreign_key: "entity_target_id"
end
