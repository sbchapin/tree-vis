# for more details see: http://emberjs.com/guides/models/defining-models/

App.Relationship = DS.Model.extend
  isDisplayed: DS.attr 'boolean', defaultValue: true
  entitySource: DS.belongsTo 'entity'
  entityTarget: DS.belongsTo 'entity'
