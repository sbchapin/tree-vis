App.RelationshipController = Ember.ObjectController.extend Em.I18n.TranslateableProperties,
  deleteForSureTranslation: 'controller.entity.deleteForSure'
  
  staticPadding: 11
  x: ( () -> 
    x1 = @get('model.entitySource.x')
    xh1 = @get('model.entitySource.width') + @staticPadding
    x2 = @get('model.entityTarget.x')
    xh2 = @get('model.entityTarget.width') + @staticPadding

    y1 = @get('model.entitySource.y')
    yh1 = @get('model.entitySource.height') + @staticPadding
    y2 = @get('model.entityTarget.y')
    yh2 = @get('model.entityTarget.height') + @staticPadding
    if x1 < x2           ##left
      if y1 + yh1 < y2      #top
        return x1
      else if y1 - yh2 < y2 #mid
        if x1 + xh1 > x2
          return x2
        return x1 + xh1
      else                  #bottom
        return x1 
    else if x1 - xh2 < x2##mid
      if y1 + yh1 < y2      #top
        return x2
      else if y1 - yh2 < y2 #mid
        return x1
      else                  #bottom
        return x2
    else                 ##right
      if y1 + yh1 < y2      #top
        return x2
      else if y1 - yh2 < y2 #mid
        return x2 + xh2
      else                  #bottom
        return x2
      
  ).property('model.entitySource.x', 'model.entitySource.width', 'model.entityTarget.y', 'model.entityTarget.height')

  y: ( () -> 
    return 100
    x1 = @get('model.entitySource.x')
    xh1 = @get('model.entitySource.width') + @staticPadding
    x2 = @get('model.entityTarget.x')
    xh2 = @get('model.entityTarget.width') + @staticPadding

    y1 = @get('model.entitySource.y')
    yh1 = @get('model.entitySource.height') + @staticPadding
    y2 = @get('model.entityTarget.y')
    yh2 = @get('model.entityTarget.height') + @staticPadding

  ).property('model.entitySource.y', 'model.entitySource.height', 'model.entityTarget.y', 'model.entityTarget.height')
  
  width: ( () -> 
    x1 = @get('model.entitySource.x')
    xh1 = @get('model.entitySource.width') + @staticPadding
    x2 = @get('model.entityTarget.x')
    xh2 = @get('model.entityTarget.width') + @staticPadding

    y1 = @get('model.entitySource.y')
    yh1 = @get('model.entitySource.height') + @staticPadding
    y2 = @get('model.entityTarget.y')
    yh2 = @get('model.entityTarget.height') + @staticPadding
    if x1 < x2           ##left
      if y1 + yh1 < y2      #top
        if x1 + xh1 > x2 + xh2
          return xh1
        return x2 - x1 + xh2
      else if y1 - yh2 < y2 #mid
        if x1 + xh1 > x2
          return x1 + xh1 - x2
        return x2 - x1 - xh1
      else                  #bottom
        if x1 + xh1 > x2 + xh2
          return xh1
        return x2 - x1 + xh2
    else if x1 - xh2 < x2##mid
      if y1 + yh1 < y2      #top
        return x1 - x2 + xh1
      else if y1 - yh2 < y2 #mid
        return (x2 + xh2) - x1
      else                  #bottom
        return x1 - x2 + xh1
    else                 ##right
      if y1 + yh1 < y2      #top
        return x1 - x2 + xh1
      else if y1 - yh2 < y2 #mid
        return x1  - x2 - xh2
      else                  #bottom
        return x1 - x2 + xh1

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
    Math.abs(y1 - y2)
    100
  ).property('model.entitySource.y', 'model.entitySource.height', 'model.entityTarget.y', 'model.entityTarget.height')

  actions:
    saveChanges: () ->
      @model.save()

    rejectChanges: () ->
      @model.rollback()

    deleteRelationship: () ->
      if confirm(@get('deleteForSure'))
        @model.destroyRecord()