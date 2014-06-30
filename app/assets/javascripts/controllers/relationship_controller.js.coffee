App.RelationshipController = Ember.ObjectController.extend Em.I18n.TranslateableProperties,
  deleteForSureTranslation: 'controller.entity.deleteForSure'
  
  # Padding for actual entity boxes
  staticPadding: 11
  bezierAccomodation: 50

  # Which connectors should be drawn
  connectors: Ember.Object.extend(
    directions: ['ne','nw','se','sw']
    update: (toUpdate=[]) -> 
      @set(direction, toUpdate.contains(direction)) for direction in @directions
    active:( () -> (direction for direction in @directions when @get(direction) == true) ).property('ne','nw','se','sw')
    ne: false
    nw: false
    se: false
    sw: false
  ).create()

  positionAndShapeUpdate: ( () -> 
    x1 = @get('model.entitySource.x')
    xh1 = @get('model.entitySource.width') + @staticPadding
    x2 = @get('model.entityTarget.x')
    xh2 = @get('model.entityTarget.width') + @staticPadding

    y1 = @get('model.entitySource.y')
    yh1 = @get('model.entitySource.height') + @staticPadding
    y2 = @get('model.entityTarget.y')
    yh2 = @get('model.entityTarget.height') + @staticPadding
    if x1+(xh1/2) < x2+(xh2/2) # west
      if y1+yh1 < y2 # north
        @connectors.update(['nw','se'])
      else if y1 > y2+yh2 #south
        @connectors.update(['ne','sw'])
      else # middle
        if y1+(yh1/2) < y2+(yh2/2)
          @connectors.update(['nw','se'])
        else
          @connectors.update(['ne','sw'])
    else # east
      if y1+yh1 < y2 # north
        @connectors.update(['ne','sw'])
      else if y1 > y2+yh2 # south
        @connectors.update(['nw','se'])
      else # middle
        if y1+(yh1/2) < y2+(yh2/2)
          @connectors.update(['ne','sw'])
        else
          @connectors.update(['nw','se'])
  ).observes('model.entitySource.x', 'model.entitySource.width', 'model.entityTarget.y', 'model.entityTarget.height').on('init')

  x: ( () -> 
    x1 = @get('model.entitySource.x')
    xh1 = @get('model.entitySource.width') + @staticPadding
    x2 = @get('model.entityTarget.x')
    xh2 = @get('model.entityTarget.width') + @staticPadding

    y1 = @get('model.entitySource.y')
    yh1 = @get('model.entitySource.height') + @staticPadding
    y2 = @get('model.entityTarget.y')
    yh2 = @get('model.entityTarget.height') + @staticPadding
    if x1+(xh1/2) < x2+(xh2/2) # west
      if y1+yh1 < y2 # north
        return x1+(xh1/2)-@bezierAccomodation
      else if y1 > y2+yh2 #south
        return x1+(xh1/2)-@bezierAccomodation
      else # mid west
        return Math.min(x1 + xh1, x2)-@bezierAccomodation
    else # east
      if y1+yh1 < y2 || y1 > y2+yh2
        return x2+(xh2/2)-@bezierAccomodation
      else # mid east
        return Math.min(x1, x2 + xh2)-@bezierAccomodation
  ).property('model.entitySource.x', 'model.entitySource.width', 'model.entityTarget.y', 'model.entityTarget.height')

  y: ( () -> 
    x1 = @get('model.entitySource.x')
    xh1 = @get('model.entitySource.width') + @staticPadding
    x2 = @get('model.entityTarget.x')
    xh2 = @get('model.entityTarget.width') + @staticPadding

    y1 = @get('model.entitySource.y')
    yh1 = @get('model.entitySource.height') + @staticPadding
    y2 = @get('model.entityTarget.y')
    yh2 = @get('model.entityTarget.height') + @staticPadding
    if y1+(yh1/2) < y2+(yh2/2)
      if x1+xh1 < x2 || x1 > x2+xh2
        if y1+yh1 < y2 || y1 > y2+yh2
          return y1+yh1-@bezierAccomodation
        return y1+(yh1/2)-@bezierAccomodation
      else # mid top
        return Math.min(y1 + yh1, y2)-@bezierAccomodation
    else
      if x1+xh1 < x2 || x1 > x2+xh2
        if y1+yh1 < y2 || y1 > y2+yh2
          return y2+yh2-@bezierAccomodation
        return y2+(yh2/2)-@bezierAccomodation
      else # mid bottom
        return Math.min(y1, y2 + yh2)-@bezierAccomodation
  ).property('model.entitySource.x', 'model.entitySource.height', 'model.entityTarget.y', 'model.entityTarget.height')
  
  width: ( () -> 
    x1 = @get('model.entitySource.x')
    xh1 = @get('model.entitySource.width') + @staticPadding
    x2 = @get('model.entityTarget.x')
    xh2 = @get('model.entityTarget.width') + @staticPadding

    y1 = @get('model.entitySource.y')
    yh1 = @get('model.entitySource.height') + @staticPadding
    y2 = @get('model.entityTarget.y')
    yh2 = @get('model.entityTarget.height') + @staticPadding
    if x1+(xh1/2) < x2+(xh2/2)
      if y1+yh1 < y2 || y1 > y2+yh2
        return x2+(xh2/2)-(x1+(xh1/2))+(@bezierAccomodation*2)
      else # mid left
        return Math.abs(x2 - (x1 + xh1))+(@bezierAccomodation*2)
    else
      if y1+yh1 < y2 || y1 > y2+yh2
        return x1+(xh1/2)-(x2+(xh2/2))+(@bezierAccomodation*2)
      else # mid right
        return Math.abs(x1 - (x2 + xh2))+(@bezierAccomodation*2)
  ).property('model.entitySource.x', 'model.entitySource.width', 'model.entityTarget.y', 'model.entityTarget.height')
 
  height: ( () -> 
    x1 = @get('model.entitySource.x')
    xh1 = @get('model.entitySource.width') + @staticPadding
    x2 = @get('model.entityTarget.x')
    xh2 = @get('model.entityTarget.width') + @staticPadding

    y1 = @get('model.entitySource.y')
    yh1 = @get('model.entitySource.height') + @staticPadding
    y2 = @get('model.entityTarget.y')
    yh2 = @get('model.entityTarget.height') + @staticPadding
    if y1+(yh1/2) < y2+(yh2/2)
      if x1+xh1 < x2 || x1 > x2+xh2
        if y1+yh1 <= y2 || y1 >= y2+yh2
          return y2-y1-yh1+(@bezierAccomodation*2)
        return y2+(yh2/2) - (y1+(yh1/2))+(@bezierAccomodation*2)
      else # mid top
        return Math.abs(y2 - (y1 + yh1))+(@bezierAccomodation*2)
    else
      if x1+xh1 < x2 || x1 > x2+xh2
        if y1+yh1 < y2 || y1 > y2+yh2
          return y1-y2-yh2+(@bezierAccomodation*2)
        return y1+(yh1/2)-(y2+(yh2/2))+(@bezierAccomodation*2)
      else # mid bottom
        return Math.abs(y1 - (y2 + yh2))+(@bezierAccomodation*2)
  ).property('model.entitySource.x', 'model.entitySource.height', 'model.entityTarget.y', 'model.entityTarget.height')

  svgViewBox: ( () -> 
    "0 0 #{@get('model.entitySource.height')} #{@get('model.entityTarget.height')}"
  ).property('model.entitySource.height', 'model.entityTarget.height')

  svgConnector: ( () -> 
    activeConnectors = @get('connectors.active')
    start = "0 0"
    startC = "0 0"
    end = "0 0"
    endC = "0 0"
    curvature = 0.5
    curvature = Math.max(Math.min(curvature, 1), 0)
    y1 = @get('model.entitySource.y')
    yh1 = @get('model.entitySource.height') + @staticPadding
    y2 = @get('model.entityTarget.y')
    yh2 = @get('model.entityTarget.height') + @staticPadding
    curvatureWidth = (@get('width') - (@bezierAccomodation*2)) * curvature
    if y1+yh1 < y2 
      curvatureWidth = Math.min(curvatureWidth, @bezierAccomodation*2 + (y2 - (y1+yh1)) )
    if y2+yh2 < y1
      curvatureWidth = Math.min(curvatureWidth, @bezierAccomodation*2 + (y1 - (y2+yh2)) )
    
      

    # endpoints
    if activeConnectors[0] == "nw"
      start = @bezierAccomodation + " " + @bezierAccomodation
      if activeConnectors[1] == "se"
        if y1+yh1 < y2 || y2+yh2 < y1
          startC = @bezierAccomodation + " " + (@bezierAccomodation + curvatureWidth)
        else
          startC = @bezierAccomodation + curvatureWidth + " " + @bezierAccomodation
    if activeConnectors[0] == "ne"
      start = (@get('width') - @bezierAccomodation) + " " + @bezierAccomodation
      if activeConnectors[1] == "sw"
        if y1+yh1 < y2 || y2+yh2 < y1
          startC = (@get('width') - @bezierAccomodation) + " " + (@bezierAccomodation + curvatureWidth)
        else
          startC = (@get('width') - @bezierAccomodation) - curvatureWidth + " " + @bezierAccomodation
    if activeConnectors[1] == "sw"
      end = @bezierAccomodation + " " + (@get('height') - @bezierAccomodation)
      if activeConnectors[0] == "ne"
        if y1+yh1 < y2 || y2+yh2 < y1
          endC = @bezierAccomodation + " " + (@get('height') - @bezierAccomodation - curvatureWidth)
        else
          endC = @bezierAccomodation + curvatureWidth + " " + (@get('height') - @bezierAccomodation)
    if activeConnectors[1] == "se"
      end = (@get('width') - @bezierAccomodation) + " " + (@get('height') - @bezierAccomodation)
      if activeConnectors[0] == "nw"
        if y1+yh1 < y2 || y2+yh2 < y1
          endC = (@get('width') - @bezierAccomodation) + " " + ((@get('height') - @bezierAccomodation) - curvatureWidth)
        else
          endC = (@get('width') - @bezierAccomodation) - curvatureWidth + " " + (@get('height') - @bezierAccomodation)
   
    return "M #{start} C #{startC} #{endC} #{end}"
  ).property('model.entitySource.x', 'model.entitySource.width', 'model.entityTarget.y', 'model.entityTarget.height')

  actions:
    saveChanges: () ->
      @model.save()

    rejectChanges: () ->
      @model.rollback()

    deleteRelationship: () ->
      if confirm(@get('deleteForSure'))
        @model.destroyRecord()