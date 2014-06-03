# for more details see: http://emberjs.com/guides/views/

App.RelationshipSourceView = Ember.View.extend
  tagName: 'div'
  classNames: 'endpoint endpoint-source'
  relationships: null #relationships defined by parent view

  # updateRelationships: (relationships) ->
  #   for relationship in relationships
  #     console.log relationship


  # relationshipsChanged: ( () ->
  #   @updateRelationships(@get('relationships.content'))
  # ).observes('relationships').observes('relationships.content').observes('relationships.content.length').observes('relationships.content.@each')

  # didInsertElement: -> 
  #   @updateRelationships(@get('relationships.content'))
  #   jsPlumb.ready =>
  #     #get instance from parent view
  #     instance = @get('parentView.instance')
  #     #suspend drawing and initialize SOURCE
  #     instance.doWhileSuspended => instance.makeSource(@$(), {anchor: "Continuous" })

  # willDestroyElement: ->
  #   instance = @get('parentView.instance')
  #   if instance
  #     #remove connections to self
  #     instance.detachAllConnections(@$())
  #     instance.repaint(@$())



App.RelationshipTargetView = Ember.View.extend
  tagName: 'div'
  classNames: 'endpoint endpoint-target'
  relationships: null #relationships defined by parent view

  # didInsertElement: -> 
  #   jsPlumb.ready =>
  #     #get instance from parent view
  #     instance = @get('parentView.instance')
  #     #suspend drawing and initialize TARGET
  #     instance.doWhileSuspended => instance.makeTarget(@$(), {anchor: "Continuous" })

  # willDestroyElement: ->
  #   instance = @get('parentView.instance')
  #   if instance
  #     #remove connections to self
  #     instance.detachAllConnections(@$())
  #     instance.repaint(@$())