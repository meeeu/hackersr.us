class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.string :title
      t.string :description
      t.string :link
      t.integer :user_id
      t.integer :node_id

      t.timestamps
    end
    add_index :notes, [:user_id, :created_at]
    add_index :notes, [:node_id, :created_at]
  end

  def self.down
    drop_table :notes
  end
end
