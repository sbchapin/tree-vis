class EntitySerializer < ActiveModel::Serializer
  embed :ids, include: true #sideload relationships
  attributes :id, :name, :description, :x, :y, :width, :height
  has_many :relationships

  # has_many :relationship_sources, root: :relationships
  # has_many :relationship_targets, root: :relationships
end
