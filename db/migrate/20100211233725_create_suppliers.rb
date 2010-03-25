class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.string :name, :null=>false
      t.string :phone
      t.string :address
      t.references :store, :null=>false
      t.references :user, :null=>false
      t.timestamps
    end
    add_foreign_key :suppliers, :stores
    add_foreign_key :suppliers, :users
  end

  def self.down
    remove_foreign_key :suppliers, :stores
    remove_foreign_key :suppliers, :users
    drop_table :suppliers
  end
end
