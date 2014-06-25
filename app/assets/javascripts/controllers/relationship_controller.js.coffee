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
    if x1+xh1/2 < x2+xh2/2
      if y1+yh1 < y2 || y1 > y2+yh2
        return x1+xh1/2
      else # mid left
        return Math.min(x1 + xh1, x2)
    else
      if y1+yh1 < y2 || y1 > y2+yh2
        return x2+xh2/2
      else # mid right
        return Math.min(x1, x2 + xh2)
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
    if y1+yh1/2 < y2+yh2/2
      if x1+xh1 < x2 || x1 > x2+xh2
        if y1+yh1 < y2 || y1 > y2+yh2
          return y1 + yh1
        return y1+yh1/2
      else # mid top
        return Math.min(y1 + yh1, y2)
    else
      if x1+xh1 < x2 || x1 > x2+xh2
        if y1+yh1 < y2 || y1 > y2+yh2
          return y2 + yh2
        return y2+yh2/2
      else # mid bottom
        return Math.min(y1, y2 + yh2)
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
    if x1+xh1/2 < x2+xh2/2
      if y1+yh1 < y2 || y1 > y2+yh2
        return x2+xh2/2 - (x1+xh1/2)
      else # mid left
        return Math.abs(x2 - (x1 + xh1))
    else
      if y1+yh1 < y2 || y1 > y2+yh2
        return x1+xh1/2 - (x2+xh2/2)
      else # mid right
        return Math.abs(x1 - (x2 + xh2))
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
    if y1+yh1/2 < y2+yh2/2
      if x1+xh1 < x2 || x1 > x2+xh2
        if y1+yh1 <= y2 || y1 >= y2+yh2
          return y2 - y1 - yh1
        return y2+yh2/2 - (y1+yh1/2)
      else # mid top
        return Math.abs(y2 - (y1 + yh1))
    else
      if x1+xh1 < x2 || x1 > x2+xh2
        if y1+yh1 < y2 || y1 > y2+yh2
          return y1 - y2 - yh2
        return y1+yh1/2 - (y2+yh2/2)
      else # mid bottom
        return Math.abs(y1 - (y2 + yh2))
  ).property('model.entitySource.y', 'model.entitySource.height', 'model.entityTarget.y', 'model.entityTarget.height')

  actions:
    saveChanges: () ->
      @model.save()

    rejectChanges: () ->
      @model.rollback()

    deleteRelationship: () ->
      if confirm(@get('deleteForSure'))
        @model.destroyRecord()