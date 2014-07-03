App.MulticlickVerifierComponent = Ember.Component.extend
  steps: 2
  curClick: 0
  classNameBindings: [ "stepClass" ] 

  stepClass: ( () -> "click-#{(@get('curClick') % @get('steps')) + 1}" ).property('curClick', 'steps')

  click: -> @set('curClick', @curClick+1)
  curClickObserver: ( () -> @sendAction() if @get('curClick') % @get('steps') == 0 ).observes('curClick', 'steps')
