App.RelationshipsController = Ember.ArrayController.extend

  # Array is dirty if any of its elements are dirty
  isDirty: false
  dirtyBubble: ( () -> 
    isDirty = false
    @get('content').forEach (entity) ->
      if entity.get("isDirty")
        isDirty ||= true
    @set('isDirty', isDirty)
  ).observes('content.@each.isDirty')

  actions:
    saveChanges: () ->
      for model in @get('content') when model.get('isDirty')
        model.save()

    rejectChanges: () ->
      for model in @get('content') when model.get('isDirty')
        model.rollback()
