# for more details see: http://emberjs.com/guides/views/
App.EntityView = Ember.View.extend Em.I18n.TranslateableProperties,
  # linked template
  templateName: 'entity'
  # jsPlumb instance (grabbed on didInsertElement from parent)
  instance: null

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
  ).property('controller.x', 'controller.y')

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
  ).property('controller.id', 'controller.isDirty', 'controller.isSaving', 'controller.isError')

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
        if instance
          instance.repaint(entity)
  ).observes('controller.x').observes('controller.y')


  didInsertElement: -> 
    jsPlumb.ready =>
      #get instance from parent view
      instance = @get('parentView.instance')
      @set('instance', instance)
      # suspend drawing and initialise.
      instance.doWhileSuspended =>
        #make it draggable
        instance.draggable @$('.entity')
