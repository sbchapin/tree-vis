#= require jquery
#= require handlebars
#= require ember
#= require ember-data
#= require i18n
#= require_self
#= require app
#= require_tree .

# for more details see: http://emberjs.com/guides/application/
window.App = Ember.Application.create
  # log when Ember generates a controller or a route from a generic class
  LOG_ACTIVE_GENERATION: true
  # log when Ember looks up a template or a view
  LOG_VIEW_LOOKUPS: true

App.ApplicationStore = DS.Store.extend({})

# Add i18n to text fields
Em.TextField.reopen(Em.I18n.TranslateableAttributes)