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

  click: (e) -> @send('cancelPick') if $(e.target).attr('id') == 'entities'
  keyDown: (e) -> @send('cancelPick') if e.keyCode == 27

  actions:
    startPick: (startingView) ->
      @$('input.sneaky-input-capture').focus() #focus to allow user to use 'esc'
      @$().addClass('picking')
      @set('isPicking', true)
      @set('startedPicking', startingView)

    endPick: (endingView) ->
      @get('startedPicking').send('endPick', endingView)
      @$().removeClass('picking')
      @set('isPicking', false)
      @set('startedPicking', null)

    cancelPick: ->
      @get('startedPicking').send('cancelPick')
      @$().removeClass('picking')
      @set('isPicking', false)
      @set('startedPicking', null)
