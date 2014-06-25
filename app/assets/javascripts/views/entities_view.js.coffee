# for more details see: http://emberjs.com/guides/views/

App.EntitiesView = Ember.View.extend Em.I18n.TranslateableProperties,
  # linked template
  templateName: 'entities'

  # translations
  newTitleTranslation:'view.generic.new'
  saveTitleTranslation:'view.generic.saveAll'
  rejectTitleTranslation:'view.generic.rejectAll'
