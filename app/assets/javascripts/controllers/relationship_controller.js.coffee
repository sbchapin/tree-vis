
App.RelationshipSourcesController = Ember.ArrayController.extend 

  actions:
    connect: (jsPlumbEvent) -> 
      #get Ember View by ID
      relationshipSourceEmberView = Ember.View.views[jsPlumbEvent.sourceId]
      relationshipTargetEmberView = Ember.View.views[jsPlumbEvent.targetId]
      if relationshipSourceEmberView && relationshipTargetEmberView
        #get parent view (Entity), then its controller
        source = relationshipSourceEmberView.get('parentView.controller.content')
        target = relationshipTargetEmberView.get('parentView.controller.content')
         
        relationships = @store.all('relationship')

        #if relationship exists, GTFO
        for relationship in relationships.get('content') 
          if (relationship.get('entitySource') == source && relationship.get('entityTarget') == target) || (relationship.get('entitySource') == target && relationship.get('entityTarget') == source)
            #relationship exists
            if relationship.get('isDisplayed')
              jsPlumb.detach(jsPlumbEvent.connection) #relationship already displayed, detach 'potential' connection
            relationship.set('isDisplayed', true)
            return
          
        #relationship doesnt exist, make it
        r = @store.createRecord 'relationship', {entitySource: source, entityTarget: target}
        r.save()

    remove: (jsPlumbEvent) -> 
      #get Ember View by ID
      relationshipSourceEmberView = Ember.View.views[jsPlumbEvent.sourceId]
      relationshipTargetEmberView = Ember.View.views[jsPlumbEvent.targetId]
      if relationshipSourceEmberView && relationshipTargetEmberView
        #get parent view (Entity), then its controller
        source = relationshipSourceEmberView.get('parentView.controller.content')
        target = relationshipTargetEmberView.get('parentView.controller.content')
         
        relationships = @store.all('relationship')

        #find relationship
        for relationship in relationships.get('content') 
          if (relationship.get('entitySource') == source && relationship.get('entityTarget') == target) || (relationship.get('entitySource') == target && relationship.get('entityTarget') == source)
            #relationship exists
            relationship.destroyRecord()
            console.log jsPlumb
            console.log jsPlumbEvent
            jsPlumb.detach(jsPlumbEvent.connection)

App.RelationshipTargetsController = Ember.ArrayController.extend 
  actions:
    doStuff: () -> console.log 'this garbage'
