# For more information see: http://emberjs.com/guides/routing/
App.Router.map ->

# #APP LEVEL
# App.ApplicationRoute = Ember.Route.extend
#   # actions: 
#   #   error: (e) -> 
#   #     true # let other error handlers catch it

App.IndexRoute = Ember.Route.extend
  setupController: (controller, model) -> 
    @store.find('entity').then (entities) -> controller.set('entities', entities)
    @store.find('relationship').then (relationships) -> controller.set('relationships', relationships)
