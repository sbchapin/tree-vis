# for more details see: http://emberjs.com/guides/views/

App.EntitiesView = Ember.View.extend Em.I18n.TranslateableProperties,
  # linked template
  templateName: 'entities'
  # jsPlumb instance
  instance: null

  # translations
  newTitleTranslation:'view.generic.new'
  saveTitleTranslation:'view.generic.saveAll'
  rejectTitleTranslation:'view.generic.rejectAll'



  didInsertElement: -> 
    jsPlumb.ready =>
      color = "gray"
      hoverColor = "#ec9f2e"
      instance = jsPlumb.getInstance(
        Connector:             [ "Bezier", { curviness:100 } ]
        ConnectionsDetachable: false
        PaintStyle:            { strokeStyle: color, lineWidth: 15 }
        EndpointStyle:         { radius: 10, fillStyle: color }
        HoverPaintStyle:       { strokeStyle: hoverColor }
        EndpointHoverStyle:    { fillStyle:   hoverColor }
        Container:             "entities"
      )
      @set('instance', instance)