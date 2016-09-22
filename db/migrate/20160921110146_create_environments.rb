class CreateEnvironments < ActiveRecord::Migration[5.0]
  def change
    create_table :environments do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.boolean :approved
      t.text :description
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
