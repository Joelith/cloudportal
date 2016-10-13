class CreateOraclecloudDatabaseConfig < ActiveRecord::Migration[5.0]
  def change
    create_table :oraclecloud_database_configs do |t|
    	t.string :service_name
    	t.integer :edition
    	t.string :ssh_key
    	t.integer :shape
    	t.string :version
    	t.integer :level
    	t.integer :subscription_type
    	t.string :description
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
