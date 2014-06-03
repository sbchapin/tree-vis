# for more details see: http://emberjs.com/guides/views/
App.EntityView = Ember.View.extend Em.I18n.TranslateableProperties,
  # linked template
  templateName: 'entity'

  # translations
  deleteTitleTranslation:'view.generic.delete'
  rejectTitleTranslation:'view.generic.reject'
  saveTitleTranslation:'view.generic.save'

  # view-relevant computed attributes
  positioningStyle: ( () -> 
    x = @get('controller.x')
    y = @get('controller.y')
    if x? && y?
      return "left: #{x}px; top: #{y}px;"
    return undefined
  ).property('controller.x controller.y')

  #update x and y when dragged
  drag: (event, ui) -> 
    pos = $(event.target).position()
    @set('controller.x', pos.left)
    @set('controller.y', pos.top)

  observeCoords: ( () ->
    #if we see it is no longer dirty, reset the position
    if !@get('controller.isDirty')
      entity = @$('.entity')
      if entity
        entity.css({left: @get('controller.x'), top: @get('controller.y')})
        instance = @get('parentView.instance')
        console.log instance
        if instance
          instance.repaint(entity)
  ).observes('controller.x').observes('controller.y')

  observeRelationships: ( () ->
    jsPlumb.ready =>
      for relationship in @get('controller.relationships.content')
        Ember.run.later(
          () =>
            instance = @get('parentView.instance')
            # if instance
            #   instance.connect({ source: @$('.entity .endpoint-source'),  target: @$('.entity .endpoint-target') })
          1000
        )

  ).observes('controller.relationships').observes('controller.relationships.content').observes('controller.relationships.content.length').observes('controller.relationships.content.@each')

  didInsertElement: -> 
    $this = @$('.entity')
    jsPlumb.ready =>
      #get instance from parent view
      instance = @get('parentView.instance')

      # suspend drawing and initialise.
      instance.doWhileSuspended =>
        #make it draggable
        instance.draggable $this
        for endpoint in $this.find('.endpoint-source')
          instance.makeSource(endpoint, {anchor: "Continuous" })

        for endpoint in $this.find('.endpoint-target')
          instance.makeTarget(endpoint, {anchor: "Continuous" })

        # for relationship in @get('controller.relationships')
        #   console.log "pe peee"
        #   instance.connect
        #     source: $this.find('.endpoint-source')
        #     target: $this.find('.endpoint-target')

  willDestroyElement: ->
    source = @$('.entity .endpoint-source')
    target = @$('.entity .endpoint-target')
    instance = @get('parentView.instance')
    if source && instance
      instance.detachAllConnections(source)
      instance.repaint(source)
    if target && instance
      instance.detachAllConnections(target)
      instance.repaint(target)
