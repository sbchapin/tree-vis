# for more details see: http://emberjs.com/guides/models/defining-models/

App.Entity = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  x: DS.attr 'number'
  y: DS.attr 'number'
  relationships: DS.hasMany 'relationship'