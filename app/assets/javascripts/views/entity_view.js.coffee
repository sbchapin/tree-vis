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

  #relocate when x and y updated
  relocate: ( () -> console.log $("##{@get('windowId')}") ).observes('controller.x controller.y').on('init')
