class AddZoomToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :zoom, :integer, default: 100
  end
end
