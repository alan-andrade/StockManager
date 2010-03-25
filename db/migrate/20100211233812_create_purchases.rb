class CreatePurchases < ActiveRecord::Migration
  def self.up
    create_table :purchases do |t|
		t.references :store, :supplier
		t.string :comments
      t.timestamps
    end
    add_foreign_key 	:purchases	,	:stores		,	:dependent=>:delete
    add_foreign_key	:purchases	,	:suppliers	,	:dependent => :delete
  end

  def self.down
	 remove_foreign_key	:purchases	,	:stores
	 remove_foreign_key	:purchases	,	:suppliers
    drop_table :purchases
  end
end
