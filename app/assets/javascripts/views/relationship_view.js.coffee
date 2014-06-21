# for more details see: http://emberjs.com/guides/views/

App.RelationshipSourcesView = Ember.View.extend
  tagName: 'div'
  classNames: 'endpoint endpoint-source'

  updateRelationships: (relationships) ->
    containingEntity = @get('parentView.controller.content')
    containingEntityId = containingEntity.get('id') 
    for relationship in relationships
      sourceId = relationship.get('entitySource.id')
      targetId = relationship.get('entityTarget.id')
      if sourceId == containingEntityId && targetId
        #provide closure for sourceId, targetId, and 'this' for deferred processing
        Ember.run.next( 
          ((s,t,_this) -> #close around function
            ->
              _this.get('parentView.instance').connect(
                source: $(".entity-#{s} .endpoint-source")
                target: $(".entity-#{t} .endpoint-target")
              )
          )(sourceId, targetId, @) #pass in saved vars
        )

  observeRelationships: ( () ->
    @updateRelationships(@get('controller.content'))
  ).observes('controller.content').observes('controller.content.length').observes('controller.content.@each')

  relationshipCreated: (info) ->
    #if the monitored relationship belonged to this source
    if info.source == @$().context
      # create relationship entity
      @controller.send('connect', info)
      console.log  info
      # set up ability to be deleted
      info.connection.bind 'click', (info) => @controller.send('remove', info)
    false
        
  didInsertElement: -> 
    jsPlumb.ready =>
      #get instance from parent view
      instance = @get('parentView.instance')
      #suspend drawing and initialize SOURCE
      instance.doWhileSuspended => 
        #make source and set up it's 'connection created' binding
        source = instance.makeSource(@$(), {anchor: "Continuous" })
        source.bind 'connection', (info) => 
          @relationshipCreated(info)
  willDestroyElement: ->
    instance = @get('parentView.instance')
    if instance
      #remove connections to self
      instance.detachAllConnections(@$())
      instance.repaint(@$())



App.RelationshipTargetsView = Ember.View.extend
  tagName: 'div'
  classNames: 'endpoint endpoint-target'
  relationships: null #relationships defined by parent view

  didInsertElement: -> 
    jsPlumb.ready =>
      #get instance from parent view
      instance = @get('parentView.instance')
      #suspend drawing and initialize TARGET
      instance.doWhileSuspended => 
        #make target
        target = instance.makeTarget(@$(), {anchor: "Continuous" })

  willDestroyElement: ->
    instance = @get('parentView.instance')
    if instance
      #remove connections to self
      instance.detachAllConnections(@$())
      instance.repaint(@$())