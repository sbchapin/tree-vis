class AddYToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :y, :double
  end
end
