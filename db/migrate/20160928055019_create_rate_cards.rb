class CreateRateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :rate_cards do |t|
      t.string :provider
      t.string :key
      t.float :value

      t.timestamps
    end
  end
end
