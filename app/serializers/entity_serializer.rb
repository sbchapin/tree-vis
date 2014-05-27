class EntitySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :x, :y
end
