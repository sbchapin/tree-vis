class RelationshipSerializer < ActiveModel::Serializer
  embed :ids, include: false
  attributes :id
  has_one :entity_source
  has_one :entity_target
end
