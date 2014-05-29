class AddYToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :y, :integer
  end
end
