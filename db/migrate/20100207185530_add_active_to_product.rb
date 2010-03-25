class AddActiveToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :active, :boolean, :default=>true, :null=>false
  end

  def self.down
    remove_column :products, :active
  end
end
