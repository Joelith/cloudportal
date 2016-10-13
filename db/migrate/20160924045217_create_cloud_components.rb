class CreateCloudComponents < ActiveRecord::Migration[5.0]
  def change
  	enable_extension "hstore" 
    create_table :cloud_components do |t|
      t.string :type
      t.text :hstore
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
