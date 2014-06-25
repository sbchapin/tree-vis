class AddWidthAndHeightToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :width, :integer, null: false, default: 0
    add_column :entities, :height, :integer, null: false, default: 0
  end
end
