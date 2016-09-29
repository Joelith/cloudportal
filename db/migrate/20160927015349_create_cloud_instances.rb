class CreateCloudInstances < ActiveRecord::Migration[5.0]
  def change
    create_table :cloud_instances do |t|
      t.string :type
      t.string :name
      t.text :init_config

      t.references :environment, foreign_key: true

      t.timestamps
    end
  end
end
