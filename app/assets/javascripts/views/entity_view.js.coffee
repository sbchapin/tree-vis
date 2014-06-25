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
    x = @get('controller.x') || 0
    y = @get('controller.y') || 0
    style = ""
    style += "left: #{x}px;" if x?
    style += "top: #{y}px;" if y?
    return style
  ).property('controller.x', 'controller.y')

  minWidth: 285
  minHeight: 135
  dimensionStyle: ( () -> 
    width = @get('controller.width') || @minWidth
    height = @get('controller.height') || @minHeight
    style = ""
    style += "width: #{width}px;" if width?
    style += "height: #{height}px;" if height?
    return style
  ).property('controller.width', 'controller.height')
  
  resetDimension: ->
    @set('controller.width', @minWidth)
    @set('controller.height', @minHeight)

  classNameBindings: 'htmlClass'
  htmlClass: ( () -> 
    classes = []

    # entity-#
    id = @get('controller.id')  
    id = 'new' if !id
    classes.push "entity-#{id}"

    # dirty
    classes.push "dirty" if @get('controller.isDirty')

    # saving
    classes.push "saving" if @get('controller.isSaving')

    # error
    classes.push "error" if @get('controller.isError')

    # new
    classes.push "new" if @get('controller.isNew')

    return classes.join(' ')
  ).property('controller.id', 'controller.isDirty', 'controller.isSaving', 'controller.isError', 'controller.isNew')

  #update x and y when dragged
  drag: (event, ui) -> 
    pos = $(event.target).position()
    @set('controller.x', pos.left)
    @set('controller.y', pos.top)

  #update width and height when resized
  resize: (event, ui) -> 
    target = $(event.target)
    @set('controller.height', target.height())
    @set('controller.width', target.width())

  observeCoords: ( () ->
    #if we see it is no longer dirty, reset the position
    if !@get('controller.isDirty')
      entity = @$('.entity')
      if entity
        entity.css({left: @get('controller.x'), top: @get('controller.y')})
        instance = @get('parentView.instance')
        if instance
          instance.repaint(entity)
  ).observes('controller.x').observes('controller.y')


  didInsertElement: -> 
    @$('.entity').draggable()
    @$('.entity-wrap').resizable(
      handles: "se"
      minHeight: @minHeight
      minWidth: @minWidth
      resize: (event, ui) => @resize(event, ui)
    )
    @$(".ui-resizable-handle.ui-resizable-se").dblclick => @resetDimension()
