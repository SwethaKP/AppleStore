class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :apple
      t.integer :orange
      t.integer :total
      t.string :token
      t.string :txn_id
      t.string :status

      t.timestamps
    end
  end
end
