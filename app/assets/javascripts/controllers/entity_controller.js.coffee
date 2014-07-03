App.EntityController = Ember.ObjectController.extend Em.I18n.TranslateableProperties,
  deleteForSureTranslation: 'controller.entity.deleteForSure'
  
  actions:
    saveChanges: () -> @get('model').save()

    rejectChanges: () -> @get('model').rollback()

    deleteEntity: () ->
      relationships = @get('model.relationships')
      entity = @get('model')
      successCount = 0
      neededSuccesses = relationships.get('length')

      if neededSuccesses == 0
        entity.destroyRecord()

      for relationship in relationships.slice(0)
        Ember.Logger.log relationship
        relationship.destroyRecord().then () => 
          successCount += 1
          entity.destroyRecord() if successCount == neededSuccesses

    createRelationship: (targetEntity) ->
      source = @get('content')
      target = targetEntity.get('content')
      if source && target && source != target
        hasRelationship = false

        sourceRelationships = source.get('relationships')
        sourceRelationships.forEach (relationship) =>
          hasRelationship ||= (relationship.get('entitySource') == target || relationship.get('entityTarget') == target)

        return if hasRelationship

        targetRelationships = target.get('relationships')
        targetRelationships.forEach (relationship) =>
          hasRelationship ||= (relationship.get('entitySource') == source || relationship.get('entityTarget') == source)

        return if hasRelationship

        r = @store.createRecord 'relationship',
          entitySource: source
          entityTarget: target
