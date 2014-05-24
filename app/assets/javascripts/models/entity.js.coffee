# for more details see: http://emberjs.com/guides/models/defining-models/

App.Entity = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
