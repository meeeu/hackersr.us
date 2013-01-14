class AddAdditionalToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean, :default => false
    add_column :users, :salt, :string
  end

  def self.down
    remove_column :users, :salt
    remove_column :users, :admin
  end
end
