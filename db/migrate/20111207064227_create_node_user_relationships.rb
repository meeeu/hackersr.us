class CreateNodeUserRelationships < ActiveRecord::Migration
  def self.up
    create_table :node_user_relationships do |t|
      t.integer :node_id
      t.integer :user_id

      t.timestamps
    end
    add_index :node_user_relationships, :node_id
    add_index :node_user_relationships, :user_id
    add_index :node_user_relationships, [:node_id, :user_id], :unique => true
  end

  def self.down
    drop_table :node_user_relationships
  end
end
