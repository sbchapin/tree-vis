App.RelationshipController = Ember.ObjectController.extend 
  needs: ['settings']
  # Padding for actual entity boxes
  staticPadding: 11
  bezierAccomodation: 50

  # Which connectors should be drawn
  connectorSource: 'nw'
  connectorTarget: 'se'

  # Settings
  maxCurve: (()-> @get('controllers.settings.setting.bezierMaxCurve') || 200).property('controllers.settings.setting.bezierMaxCurve')
  curvature: (()-> @get('controllers.settings.setting.bezierCurvature') || 0.5).property('controllers.settings.setting.bezierCurvature')


  # boundary calculation functions
  x: (x1, xh1, x2, xh2, y1, yh1, y2, yh2) -> 
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
  y: (x1, xh1, x2, xh2, y1, yh1, y2, yh2) -> 
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
  width: (x1, xh1, x2, xh2, y1, yh1, y2, yh2) -> 
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
  height: (x1, xh1, x2, xh2, y1, yh1, y2, yh2) -> 
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
  

  
  # cachedProperty is a property caching tool that allows a value of a field to be calculated once every so often; and cached otherwise.
  #
  # @param [String] propertyName  Identifier of property to cache
  # @param [Number] updateInterval  Number of milliseconds that must pass to invalidate cache
  # @param [Function] toRun  Function to run that calculates the cached value.  Will be bound object scope.
  #
  cachedProperty: (propertyName, updateInterval, toRun) ->
    propertyName = propertyName + @get('id')
    if @registeredUpdates[propertyName] == undefined
      @registeredUpdates[propertyName] = {last: toRun.bind(@)(), updated: Date.now()}
    else if (Date.now() - @registeredUpdates[propertyName].updated) > updateInterval
      @registeredUpdates[propertyName].updated = Date.now()
      @registeredUpdates[propertyName].last = toRun.bind(@)()
    return @registeredUpdates[propertyName].last
  registeredUpdates: Ember.Object.create()

  # positioningStyle is a property that expresses the relationship's absolute positioning in CSS
  #
  positioningStyle: ( () -> @cachedProperty 'positioningStyle', 16, () ->
    x1 = @get('model.entitySource.x')
    xh1 = @get('model.entitySource.width') + @staticPadding
    x2 = @get('model.entityTarget.x')
    xh2 = @get('model.entityTarget.width') + @staticPadding

    y1 = @get('model.entitySource.y')
    yh1 = @get('model.entitySource.height') + @staticPadding
    y2 = @get('model.entityTarget.y')
    yh2 = @get('model.entityTarget.height') + @staticPadding

    x = @x(x1, xh1, x2, xh2, y1, yh1, y2, yh2)
    width = @width(x1, xh1, x2, xh2, y1, yh1, y2, yh2)
    y = @y(x1, xh1, x2, xh2, y1, yh1, y2, yh2)
    height = @height(x1, xh1, x2, xh2, y1, yh1, y2, yh2)


    # connectors update
    if x1+(xh1/2) < x2+(xh2/2) # west
      if y1+yh1 < y2 # north
        @setProperties {connectorSource: 'nw', connectorTarget: 'se'}
      else if y1 > y2+yh2 #south
        @setProperties {connectorSource: 'ne', connectorTarget: 'sw'}
      else # middle
        if y1+(yh1/2) < y2+(yh2/2)
          @setProperties {connectorSource: 'nw', connectorTarget: 'se'}
        else
          @setProperties {connectorSource: 'ne', connectorTarget: 'sw'}
    else # east
      if y1+yh1 < y2 # north
        @setProperties {connectorSource: 'ne', connectorTarget: 'sw'}
      else if y1 > y2+yh2 # south
        @setProperties {connectorSource: 'nw', connectorTarget: 'se'}
      else # middle
        if y1+(yh1/2) < y2+(yh2/2)
          @setProperties {connectorSource: 'ne', connectorTarget: 'sw'}
        else
          @setProperties {connectorSource: 'nw', connectorTarget: 'se'}

    return "left: #{x}px; width: #{width}px; top: #{y}px; height: #{height}px;"
  ).property('model.entitySource.x', 'model.entitySource.width', 'model.entitySource.y', 'model.entitySource.height', 'model.entityTarget.x', 'model.entityTarget.width', 'model.entityTarget.y', 'model.entityTarget.height')

  # svgConnector is a property that expresses the relationship's curvature in vector notation
  #
  svgConnector: ( () -> 
    start = "0 0"
    startC = "0 0"
    end = "0 0"
    endC = "0 0"
    curvature = Math.max(Math.min(@get('curvature'), 1), 0)
    
    x1 = @get('model.entitySource.x')
    xh1 = @get('model.entitySource.width') + @staticPadding
    x2 = @get('model.entityTarget.x')
    xh2 = @get('model.entityTarget.width') + @staticPadding

    y1 = @get('model.entitySource.y')
    yh1 = @get('model.entitySource.height') + @staticPadding
    y2 = @get('model.entityTarget.y')
    yh2 = @get('model.entityTarget.height') + @staticPadding
    

    width = @width(x1, xh1, x2, xh2, y1, yh1, y2, yh2)
    height = @height(x1, xh1, x2, xh2, y1, yh1, y2, yh2)

    curvatureWidth = (width - (@bezierAccomodation*2)) * curvature
    if y1+yh1 < y2 
      curvatureWidth = Math.min(curvatureWidth, @bezierAccomodation*2 + (y2 - (y1+yh1)) )
    if y2+yh2 < y1
      curvatureWidth = Math.min(curvatureWidth, @bezierAccomodation*2 + (y1 - (y2+yh2)) )
    curvatureWidth = Math.min(@get('maxCurve'), curvatureWidth)


    # endpoints
    if @connectorSource == "nw"
      start = @bezierAccomodation + " " + @bezierAccomodation
      if @connectorTarget == "se"
        if y1+yh1 < y2 || y2+yh2 < y1
          startC = @bezierAccomodation + " " + (@bezierAccomodation + curvatureWidth)
        else
          startC = @bezierAccomodation + curvatureWidth + " " + @bezierAccomodation
    if @connectorSource == "ne"
      start = (width - @bezierAccomodation) + " " + @bezierAccomodation
      if @connectorTarget == "sw"
        if y1+yh1 < y2 || y2+yh2 < y1
          startC = (width - @bezierAccomodation) + " " + (@bezierAccomodation + curvatureWidth)
        else
          startC = (width - @bezierAccomodation) - curvatureWidth + " " + @bezierAccomodation
    if @connectorTarget == "sw"
      end = @bezierAccomodation + " " + (height - @bezierAccomodation)
      if @connectorSource == "ne"
        if y1+yh1 < y2 || y2+yh2 < y1
          endC = @bezierAccomodation + " " + (height - @bezierAccomodation - curvatureWidth)
        else
          endC = @bezierAccomodation + curvatureWidth + " " + (height - @bezierAccomodation)
    if @connectorTarget == "se"
      end = (width - @bezierAccomodation) + " " + (height - @bezierAccomodation)
      if @connectorSource == "nw"
        if y1+yh1 < y2 || y2+yh2 < y1
          endC = (width - @bezierAccomodation) + " " + ((height - @bezierAccomodation) - curvatureWidth)
        else
          endC = (width - @bezierAccomodation) - curvatureWidth + " " + (height - @bezierAccomodation)
    return "M #{start} C #{startC} #{endC} #{end}"
  ).property('model.entitySource.x', 'model.entitySource.width', 'model.entitySource.y', 'model.entitySource.height', 'model.entityTarget.x', 'model.entityTarget.width', 'model.entityTarget.y', 'model.entityTarget.height', 'curvature', 'maxCurve')

  actions:
    saveChanges: () -> @get('model').save()

    rejectChanges: () -> @get('model').rollback()

    deleteEntity: () -> @get('model').destroyRecord()
