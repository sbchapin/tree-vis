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



  didInsertElement: -> 
    $this = @$('.entity')
    jsPlumb.ready =>
      #get instance from parent view
      instance = @get('parentView.instance')

      # suspend drawing and initialise.
      instance.doWhileSuspended =>
        console.log $this
        #make it draggable
        instance.draggable $this
        for endpoint in $this.find('.endpoint-source')
          instance.makeSource(endpoint, {anchor: "Continuous" })

        for endpoint in $this.find('.endpoint-target')
          instance.makeTarget(endpoint, {anchor: "Continuous" })


