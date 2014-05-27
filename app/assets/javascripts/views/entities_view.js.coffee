# for more details see: http://emberjs.com/guides/views/

App.EntitiesView = Ember.View.extend
  templateName: 'entities'
  instance: null #jsPlumb instance

  didInsertElement: -> 
    jsPlumb.ready =>
      color = "gray"
      instance = jsPlumb.getInstance(
        Connector:          [ "Bezier", { curviness:50 } ]
        PaintStyle:         { strokeStyle: color, lineWidth:5 }
        EndpointStyle:      { radius:9, fillStyle: color }
        HoverPaintStyle:    { strokeStyle: "#ec9f2e" }
        EndpointHoverStyle: { fillStyle: "#ec9f2e" }
        Container:          "entities"
      )
      @set('instance', instance)