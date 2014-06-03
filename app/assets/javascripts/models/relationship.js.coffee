# for more details see: http://emberjs.com/guides/models/defining-models/

App.Relationship = DS.Model.extend
  entitySource: DS.belongsTo 'entity'
  entityTarget: DS.belongsTo 'entity'
