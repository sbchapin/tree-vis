# for more details see: http://emberjs.com/guides/views/
App.RelationshipView = Ember.View.extend
  # linked template
  templateName: 'relationship'


  # view-relevant computed attributes
  positioningStyle: ( () -> 
    x = @get('controller.x')
    width = @get('controller.width')
    y = @get('controller.y')
    height = @get('controller.height')
    if x? && width? && y? && height?
      return "left: #{x}px; width: #{width}px; top: #{y}px; height: #{height}px;"
    return undefined
  ).property('controller.x', 'controller.width', 'controller.y', 'controller.height')

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

