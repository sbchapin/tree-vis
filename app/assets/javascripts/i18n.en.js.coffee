# Using Ember i18n translations
# https://github.com/jamesarosen/ember-i18n

Em.I18n.translations =
	controller:
		entity:
			deleteForSure: 'Are you sure you want to delete this?'

	view:
		generic:
			clear: 'Clear'
			delete: 'Delete'
			download: 'Download'
			edit: 'Edit'
			new: 'New'
			reject: 'Reject changes'
			rejectAll: 'Reject all changes'
			save: 'Save changes'
			saveAll: 'Save all changes'
			search: 'Search'
			show: 'Show'
		entities:
			header: 'Entities'
			notification: 'NOTE: Server-side relationships not implemented.  Only mobile support is through touch-punch.'
		settings:
			pixels: 'Pixels'
			decimalPercentage: '0 to 1'

	model:
		meta:
			isDirty: 'Is Dirty?'
		
		entity: 'Entity'
		entities: 'Entities'

		relationship: 'Relationship'
		relationships: 'Relationships'

		attributes:
			entities:
				id: 'ID'
				name: 'Name'
				description: 'Description'
			settings:
				bezierCurvature: 'Curvature'
				bezierMaxCurve: 'Maximum curve size'
				defaultHeight: 'Default entity height'
				defaultWidth: 'Default entity width'
