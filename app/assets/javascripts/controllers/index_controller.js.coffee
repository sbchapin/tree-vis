App.IndexController = Ember.ArrayController.extend
  needs: [ 'settings' ]
  isDirty: ( () ->
    isDirty = false
    (@get('entities.content') || []).forEach (entity) -> 
      isDirty ||= true if entity.get("isDirty")
    (@get('relationships.content') || []).forEach (relationship) -> 
      isDirty ||= true if relationship.get("isDirty")
    isDirty ||= @get('controllers.settings.setting.isDirty')
    isDirty
  ).property('entities.content.@each.isDirty', 'relationships.content.@each.isDirty', 'controllers.settings.setting.isDirty')
  
  defaultWidth:  ( () ->@get('controllers.settings.setting.defaultWidth') ).property('controllers.settings.setting.defaultWidth')
  defaultHeight: ( () ->@get('controllers.settings.setting.defaultHeight')).property('controllers.settings.setting.defaultHeight')

  actions:
    saveChanges: () ->
      @get('controllers.settings').send('saveChanges')

      entities = @get('entities.content')
      possiblyDirtyEntities = entities.get('length')
      successCount = 0

      # define function to save relationships
      saveRelationships = () => @get('relationships.content').forEach (relationship) =>
        relationship.save() if relationship.get('isDirty')

      # Save all entities first
      entities.forEach (entity) =>
        if entity.get('isDirty')
          entity.save().then () =>
            successCount += 1
            # Then save all relationships
            if successCount == possiblyDirtyEntities
              saveRelationships()
        else
          possiblyDirtyEntities -= 1

      # If no entities to save, save relationships
      if possiblyDirtyEntities == 0
        saveRelationships()
      
    rejectChanges: () ->
      @get('controllers.settings').send('rejectChanges')
      
      @get('entities.content').forEach (entity) ->
        entity.rollback() if entity.get('isDirty')
      @get('relationships.content').forEach (relationship) ->
        relationship.rollback() if relationship.get('isDirty')

    newEntity: (x, y) -> 
      defaultWidth = @get('defaultWidth')
      defaultHeight = @get('defaultHeight')
      dimensions = {x: x, y: y}
      dimensions["width"] = defaultWidth if defaultWidth?
      dimensions["height"] = defaultHeight if defaultHeight?
      @store.createRecord 'entity', dimensions


    showSettings: () -> @set('settingsMenu', true)
    hideSettings: () -> @set('settingsMenu', false)