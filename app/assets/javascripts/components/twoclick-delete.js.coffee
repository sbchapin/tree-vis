App.TwoclickDeleteComponent = App.MulticlickVerifierComponent.extend
  classNames: ['btn']
  steps: 2
  isVolatile: ( () -> @get('curClick') % @get('steps') == 1).property('curClick')
  stepClass: ( () -> if @get('isVolatile') then 'danger' else 'default' ).property('isVolatile')
