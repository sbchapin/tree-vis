class AddXToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :x, :integer
  end
end
