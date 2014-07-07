App.Setting = DS.Model.extend
  bezierCurvature: DS.attr('number')
  bezierMaxCurve: DS.attr('number')
  defaultHeight: DS.attr('number')
  defaultWidth: DS.attr('number')
  zoom: DS.attr('number')
