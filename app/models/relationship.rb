class Relationship < ActiveRecord::Base
  belongs_to :entity_source, class_name: "Entity", foreign_key: "entity_source_id"
  belongs_to :entity_target, class_name: "Entity", foreign_key: "entity_target_id"

  validates :entity_source, presence: true
  validates :entity_target, presence: true
  validates :entity_target, uniqueness: {scope: :entity_source }
end
