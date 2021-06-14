class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.references :user
      t.references :item
      t.timestamps
    end
  end
end
