# For more information see: http://emberjs.com/guides/routing/
App.Router.map ->
  @resource 'entities'

# #APP LEVEL
# App.ApplicationRoute = Ember.Route.extend
#   # actions: 
#   #   error: (e) -> 
#   #     true # let other error handlers catch it


#DOCS
App.EntitiesRoute = Ember.Route.extend
  setupController: (controller) -> controller

