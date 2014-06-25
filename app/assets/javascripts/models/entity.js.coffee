# for more details see: http://emberjs.com/guides/models/defining-models/

App.Entity = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  x: DS.attr 'number'
  width: DS.attr 'number', defaultValue: 285
  y: DS.attr 'number'
  height: DS.attr 'number', defaultValue: 135
  
  relationships: DS.hasMany 'relationship'