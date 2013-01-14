class FixPasswordColumn < ActiveRecord::Migration
  def self.up
    rename_column :users, :password, :encrypted_password
  end

  def self.down
  end
end
