# For more information see: http://emberjs.com/guides/routing/
App.Router.map ->

# #APP LEVEL
# App.ApplicationRoute = Ember.Route.extend
#   # actions: 
#   #   error: (e) -> 
#   #     true # let other error handlers catch it



#DOCS
App.IndexRoute = Ember.Route.extend
  setupController: (controller, model) -> 
    entities = @store.find('entity')
    relationships = @store.find('relationship')
    controller.set('entities', entities)
    controller.set('relationships', relationships)
