class CreateCloudConfig < ActiveRecord::Migration[5.0]
  def change
    create_table :cloud_configs do |t|
		  t.actable
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
