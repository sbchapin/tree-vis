# For more information see: http://emberjs.com/guides/routing/
App.Router.map ->
  @resource 'entities'

# #APP LEVEL
# App.ApplicationRoute = Ember.Route.extend
#   # actions: 
#   #   error: (e) -> 
#   #     true # let other error handlers catch it

App.IndexRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo('entities')


#DOCS
App.EntitiesRoute = Ember.Route.extend
  model: (params) -> @store.find('entity')
