App.EntitiesController = Ember.ArrayController.extend

  # Array is dirty if any of its elements are dirty
  isDirty: false
  dirtyBubble: ( () -> 
    isDirty = false
    @get('content').forEach (entity) ->
      if entity.get("isDirty")
        isDirty ||= true
    @set('isDirty', isDirty)
  ).observes('content.@each.isDirty').on('init')

  actions:
    saveChanges: () ->
      model = @get('model')
      model.save()

    rejectChanges: () ->
      for model in @get('model.content')
        model.rollback()

    newEntity: () ->
      post = @store.createRecord('entity')
