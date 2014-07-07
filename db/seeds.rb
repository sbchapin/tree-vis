# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
antimass = Entity.find_or_create_by name: "Antimass Deflectors", description: "Your deflectors can't repel flavor of THAT magnitude!"
cybernetics = Entity.find_or_create_by name: "Cybernetics", description: "Cyber me harder"
xrds = Entity.find_or_create_by name: "XRDS Transporters", description: "Xeno-Reductive Demi-Snarfle"

Relationship.find_or_create_by entity_source: antimass, entity_target: xrds
Relationship.find_or_create_by entity_source: antimass, entity_target: cybernetics