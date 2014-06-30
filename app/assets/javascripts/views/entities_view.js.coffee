# for more details see: http://emberjs.com/guides/views/

App.EntitiesView = Ember.View.extend Em.I18n.TranslateableProperties,
  # linked template
  templateName: 'entities'

  # translations
  newTitleTranslation:'view.generic.new'
  saveTitleTranslation:'view.generic.saveAll'
  rejectTitleTranslation:'view.generic.rejectAll'

  isPicking: false
  startedPicking: null

  actions:
    startPick: (startingView) ->
      @$().addClass('picking')
      @set('isPicking', true)
      @set('startedPicking', startingView)
    endPick: (endingView) ->
      @get('startedPicking').send('endPick', endingView)
      @$().removeClass('picking')
      @set('isPicking', false)
      @set('startedPicking', null)
