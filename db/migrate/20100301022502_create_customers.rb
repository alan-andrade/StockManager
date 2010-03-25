class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :name, :null=>false
      t.string :phone
      t.string :address
      t.string :references
    end
  end

  def self.down
    drop_table :customers
  end
end
