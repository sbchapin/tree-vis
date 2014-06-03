class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :entity_source_id
      t.integer :entity_target_id
      t.index :entity_source_id
      t.index :entity_target_id
      t.timestamps
    end
  end
end
