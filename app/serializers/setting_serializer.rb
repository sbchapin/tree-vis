class SettingSerializer < ActiveModel::Serializer
  attributes :id, :bezier_curvature, :bezier_max_curve, :default_height, :default_width

  # potentially use 'filter'.  This was a bug with ActiveModelSerializer at the time.
  # def attributes
  # 	keys = super
  # 	keys.delete :bezier_curvature
  # 	keys.delete :bezier_max_curve
  # 	keys
  # end
end
