class CreateCloudComponents < ActiveRecord::Migration[5.0]
  def change
    create_table :cloud_components do |t|
      t.string :type
      t.text :config
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
