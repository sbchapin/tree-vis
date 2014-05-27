# for more details see: http://emberjs.com/guides/views/

App.EntitiesView = Ember.View.extend
  templateName: 'entities'
  instance: null #jsPlumb instance

  didInsertElement: -> 
    jsPlumb.ready ->
      color = "gray"
      @instance = jsPlumb.getInstance(
        Connector:          [ "Bezier", { curviness:50 } ]
        PaintStyle:         { strokeStyle: color, lineWidth:5 }
        EndpointStyle:      { radius:9, fillStyle: color }
        HoverPaintStyle:    { strokeStyle: "#ec9f2e" }
        EndpointHoverStyle: { fillStyle: "#ec9f2e" }
        Container:          "entities"
      )
      
      # suspend drawing and initialise.
      @instance.doWhileSuspended ->
        @instance.draggable $(".entities .entity")

        for e in $(".entities .entity .endpoint-source")
          p = e.parentNode
          @instance.makeSource e,
            parent: p
            anchor: "Continuous"

        # for e in $(".entities .entity .endpoint-target")
        #   p = e.parentNode
        #   @instance.makeSource e,
        #     parent: p
        #     anchor: "Continuous"

        # for e in $(".entities .entity .endpoint-target")
        #   instance.makeTarget e, anchor: "Continuous"
        window.eee = @instance
        @instance.makeTarget('entity2', { anchor: "Continuous" })

        # @instance.connect({ source: $('#endpoint-top1'), target: $('#endpoint-bottom2') })
        @instance.connect({ source: 'entity1', target: 'entity2' })
        @instance.connect({ source: 'entity1', target: 'entity2' })
        @instance.connect({ source: 'entity1', target: 'entity2' })
        # @instance.connect({ source: $('#entity1'), target: $('#entity2') })

