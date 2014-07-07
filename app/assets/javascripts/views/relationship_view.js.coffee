# for more details see: http://emberjs.com/guides/views/
App.RelationshipView = Ember.View.extend Em.I18n.TranslateableProperties,
  # linked template
  templateName: 'relationship'

  # translations
  deleteTitleTranslation:'view.generic.delete'
  rejectTitleTranslation:'view.generic.reject'
  saveTitleTranslation:'view.generic.save'

  classNameBindings: 'htmlClass'
  htmlClass: ( () -> 
    classes = []

    # relationship-#
    id = @get('controller.id')  
    id = 'new' if !id
    classes.push "relationship-#{id}"

    # dirty
    classes.push "dirty" if @get('controller.isDirty')

    # saving
    classes.push "saving" if @get('controller.isSaving')

    # error
    classes.push "error" if @get('controller.isError')

    # new
    classes.push "new" if @get('controller.isNew')

    return classes.join(' ')
  ).property('controller.id', 'controller.isDirty', 'controller.isSaving', 'controller.isError', 'controller.isNew')

