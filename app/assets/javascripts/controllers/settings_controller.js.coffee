App.SettingsController = Ember.ObjectController.extend
  
  # setup model
  init: -> 
    @_super()
    @store.find('setting').then (settings) => @set('model', settings)
    
  # singular setting
  setting: (() -> (@get('model.content') || [null])[0]).property('model', 'model.content')

  actions:
    saveChanges: () -> @get('model').save()

    rejectChanges: () -> model.rollback() for model in @get('model.content') when model.get('isDirty')
