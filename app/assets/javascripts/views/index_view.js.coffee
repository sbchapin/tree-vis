App.IndexView = Ember.View.extend
  # linked template
  templateName: 'index'
  actions:
    newEntity: () ->
      #positions next to the button regardless of where we are
      @get('controller').send('newEntity', $('body').scrollLeft() + $('#main-menu').width(), $('body').scrollTop() + $('.icon-move:first').height()/2)