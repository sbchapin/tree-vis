App.MainMenuToggleComponent = Ember.Component.extend
  classNameBindings: [ "depressedClass" ] 
  classNames: [ "btn", "toggle" ] 
  depressed: false
  depressedClass: ( () -> "active" if @get('depressed') ).property('depressed')
  click: -> @set('depressed', !@get('depressed'))
  curClickObserver: ( () -> if @get('depressed') then @sendAction('press') else @sendAction('release') ).observes('depressed')
