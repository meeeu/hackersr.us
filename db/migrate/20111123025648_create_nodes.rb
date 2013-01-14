class CreateNodes < ActiveRecord::Migration
  def self.up
    create_table :nodes do |t|
      t.string :name
      t.string :continent
      t.string :country
      t.string :state
      t.string :city

      t.timestamps
    end
  end

  def self.down
    drop_table :nodes
  end
end
