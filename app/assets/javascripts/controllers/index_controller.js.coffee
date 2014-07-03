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

      # Save all entities first
      entities.forEach (entity) =>
        if entity.get('isDirty')
          entity.save().then () =>
            successCount += 1

            # Then save all relationships
            if successCount == possiblyDirtyEntities
              @get('relationships.content').forEach (relationship) ->
                relationship.save() if relationship.get('isDirty')
        else
          possiblyDirtyEntities -= 1

      
    rejectChanges: () ->
      @get('entities.content').forEach (entity) ->
        entity.rollback() if entity.get('isDirty')
      @get('relationships.content').forEach (relationship) ->
        relationship.rollback() if relationship.get('isDirty')

    newEntity: () ->
      post = @store.createRecord('entity')
      post.set('x', 400)
      post.set('y', 400)
