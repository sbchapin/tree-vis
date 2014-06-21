App.EntityController = Ember.ObjectController.extend Em.I18n.TranslateableProperties,
  deleteForSureTranslation: 'controller.entity.deleteForSure'
  
  actions:
    saveChanges: () ->
      model = @get('model')
      model.save()

    rejectChanges: () ->
      model = @get('model')
      model.rollback()

    deleteEntity: () ->
      if confirm(@get('deleteForSure'))
        model = @get('model')
        model.destroyRecord()