#= require jquery
#= require jquery.ui.draggable
#= require jquery.ui.droppable
#= require touch-punch-min
#= require jquery-jsplumb-1.6.2-min
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

#Rails CSRF token fix
$ ->
  token = $('meta[name="csrf-token"]').attr('content')
  $.ajaxPrefilter (options, originalOptions, xhr) ->
    xhr.setRequestHeader('X-CSRF-Token', token)

#fix for touch punch
$('.input').bind 'click', () -> $(this).focus()
