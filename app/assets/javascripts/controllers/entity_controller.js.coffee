App.EntityController = Ember.ObjectController.extend
  actions:
    saveChanges: () ->
      model = @get('model')
      model.save()

    rejectChanges: () ->
      model = @get('model')
      model.rollback()

    deleteEntity: () ->
      model = @get('model')
      model.destroyRecord()    	