# for more details see: http://emberjs.com/guides/views/

App.EntityView = Ember.View.extend
  templateName: 'entity'
  positioningStyle: ( () -> 
    x = @get('controller.x')
    y = @get('controller.y')
    if x? && y?
      return "left: #{x}px; top: #{y}px;"
    return undefined
  ).property('controller.x controller.y')
  windowId: ( () -> 'entity' + @get('controller.id') ).property('controller.id')
  endpointTargetId: ( () -> 'endpoint-target' + @get('controller.id') ).property('controller.id')
  endpointSourceId: ( () -> 'endpoint-source' + @get('controller.id') ).property('controller.id')

  #update x and y when dragged
  drag: (event, ui) -> 
  	pos = $(event.target).position()
  	@set('controller.x', pos.left)
  	@set('controller.y', pos.top)

  didInsertElement: -> 
    jsPlumb.ready =>
      #get instance from parent view
      instance = @get('parentView.instance')

      # suspend drawing and initialise.
      instance.doWhileSuspended =>
        $this = $("##{@get('windowId')}")

        #make it draggable
        instance.draggable $this

        for endpoint in $this.find('.endpoint-source')
          instance.makeSource(endpoint, {anchor: "Continuous" })

        for endpoint in $this.find('.endpoint-target')
          instance.makeTarget(endpoint, {anchor: "Continuous" })

        # instance.makeTarget($this, { anchor: "Continuous" })

        # instance.connect({ source: 'entity1', target: 'entity2' })

