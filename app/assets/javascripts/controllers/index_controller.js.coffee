App.IndexController = Ember.ArrayController.extend

  isDirty: ( () ->
    isDirty = false
    (@get('entities.content') || []).forEach (entity) -> 
      isDirty ||= true if entity.get("isDirty")
    (@get('relationships.content') || []).forEach (relationship) -> 
      isDirty ||= true if relationship.get("isDirty")
    isDirty
  ).property('entities.content.@each.isDirty', 'relationships.content.@each.isDirty')

  actions:
    saveChanges: () ->
      entities = @get('entities.content')
      possiblyDirtyEntities = entities.get('length')
      successCount = 0

      # define function to save relationships
      getRelationships = () => @get('relationships.content').forEach (relationship) =>
        relationship.save() if relationship.get('isDirty')

      # Save all entities first
      entities.forEach (entity) =>
        if entity.get('isDirty')
          entity.save().then () =>
            successCount += 1
            console.log successCount
            # Then save all relationships
            if successCount == possiblyDirtyEntities
              getRelationships()
        else
          possiblyDirtyEntities -= 1

      # If no entities to save, save relationships
      if possiblyDirtyEntities == 0
        getRelationships()
      
    rejectChanges: () ->
      @get('entities.content').forEach (entity) ->
        entity.rollback() if entity.get('isDirty')
      @get('relationships.content').forEach (relationship) ->
        relationship.rollback() if relationship.get('isDirty')

    newEntity: (x, y) -> @store.createRecord 'entity', {x: x, y: y}
