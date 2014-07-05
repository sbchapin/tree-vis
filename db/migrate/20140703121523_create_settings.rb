class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.decimal :bezier_curvature, precision: 4, scale: 3
      t.integer :bezier_max_curve
      t.integer :default_height
      t.integer :default_width

      t.timestamps
    end
  end
end
