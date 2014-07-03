App.EntitiesController = Ember.ArrayController.extend

  # Array is dirty if any of its elements are dirty
  isDirty: false
  dirtyBubble: ( () -> 
    isDirty = false
    @get('content').forEach (entity) ->
      if entity.get("isDirty")
        isDirty ||= true
    @set('isDirty', isDirty)
  ).observes('content.@each.isDirty')
  
  boundingBox: ( () -> 
    ultimateWidth = window.innerWidth-20
    ultimateHeight = window.innerHeight-10
    entities = @get('content') || []
    entities.forEach (entity) ->
      width = entity.get("x") + entity.get("width")
      ultimateWidth = width if width > ultimateWidth
      height = entity.get("y") + entity.get("height")
      ultimateHeight = height if height > ultimateHeight
    "height:#{ultimateHeight}px;width:#{ultimateWidth}px;"
  ).property('content.@each.x', 'content.@each.width', 'content.@each.y', 'content.@each.height')
