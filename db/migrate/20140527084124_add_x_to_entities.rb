class AddXToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :x, :double
  end
end
